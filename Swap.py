from sys import maxsize
def BacktrackMain(string):
	n = len(string)
	s1 = set()
	s1.add(string[0])
	for i in range(1, n):
		if string[i] == string[i - 1]:
			continue
		if string[i] in s1:
			return False
		s1.add(string[i])
	return True
def James_Swap(string, l, r, count, minm):
	if l == r:
		if BacktrackMain(string):
			return count
		else:
			return maxsize
	for i in range(l + 1, r + 1, 1):
		string[i], string[l] = string[l], string[i]
		count += 1
		x = James_Swap(string, l + 1, r, count, minm)
		string[i], string[l] = string[l], string[i]
		count -= 1

		y = James_Swap(string, l + 1, r, count, minm)
		minm = min(minm, min(x, y))
	return minm

test = int(input())
for _  in range(test):
    string = input()
    string = list(string)
    n = len(string)
    count = 0
    minm = maxsize
    print(James_Swap(string, 0, n - 1, count, minm))

