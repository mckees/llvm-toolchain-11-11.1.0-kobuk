//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// UNSUPPORTED: libcpp-has-no-threads
// XFAIL: *

// ALLOW_RETRIES: 2

// <condition_variable>

// class condition_variable;

// template <class Rep, class Period>
//     cv_status
//     wait_for(unique_lock<mutex>& lock,
//              const chrono::duration<Rep, Period>& rel_time);

#include <condition_variable>
#include <mutex>
#include <thread>
#include <chrono>
#include <cassert>

#include "test_macros.h"

std::condition_variable cv;
std::mutex mut;

int test1 = 0;
int test2 = 0;

int runs = 0;

void f()
{
    typedef std::chrono::system_clock Clock;
    typedef std::chrono::milliseconds milliseconds;
    std::unique_lock<std::mutex> lk(mut);
    assert(test2 == 0);
    test1 = 1;
    cv.notify_one();
    Clock::time_point t0 = Clock::now();
    while (test2 == 0 &&
           cv.wait_for(lk, milliseconds(250)) == std::cv_status::no_timeout)
        ;
    Clock::time_point t1 = Clock::now();
    if (runs == 0)
    {
        assert(t1 - t0 < milliseconds(250));
        assert(test2 != 0);
    }
    else
    {
        assert(t1 - t0 - milliseconds(250) < milliseconds(50));
        assert(test2 == 0);
    }
    ++runs;
}

int main(int, char**)
{
    {
        std::unique_lock<std::mutex>lk(mut);
        std::thread t(f);
        assert(test1 == 0);
        while (test1 == 0)
            cv.wait(lk);
        assert(test1 != 0);
        test2 = 1;
        lk.unlock();
        cv.notify_one();
        t.join();
    }
    test1 = 0;
    test2 = 0;
    {
        std::unique_lock<std::mutex>lk(mut);
        std::thread t(f);
        assert(test1 == 0);
        while (test1 == 0)
            cv.wait(lk);
        assert(test1 != 0);
        lk.unlock();
        t.join();
    }

  return 0;
}
