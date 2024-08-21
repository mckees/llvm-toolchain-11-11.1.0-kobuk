// RUN: %clang -g -o %t %s
// RUN: %lldb -s %S/basic_lldb.in %t | grep "main at basic_lldb.c:"
// REQUIRES: lldb, clang
// XFAIL: i686, i386

int main() {
	int a=0;
	return a;
}
