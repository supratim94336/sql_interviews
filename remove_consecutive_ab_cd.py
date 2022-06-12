# Problem: from a string where everything is of upper case remove all combinations of ('A', 'B') or ('C', 'D') e.g. 'AB', 'BA', 'CD', 'DC'
# input: ABCADBCD
# ans: CADB

def solution(S):
    # convert into list
    chars = list(S)

    # i <-- iterator for current string
    i = 0
    # k <-- iterator for output string
    k = 0
    # do till the end of the string is reached
    while i < len(chars):
        # finding AB
        if chars[i] == 'A' and (k > 0 and chars[k - 1] == 'B'):
            k = k - 1
            i = i + 1
        # finding BA
        elif chars[i] == 'B' and (k > 0 and chars[k - 1] == 'A'):
            k = k - 1
            i = i + 1
        # finding CD
        elif chars[i] == 'C' and (k > 0 and chars[k - 1] == 'D'):
            k = k - 1
            i = i + 1
        # finding DC
        elif chars[i] == 'D' and (k > 0 and chars[k - 1] == 'C'):
            k = k - 1
            i = i + 1
        # if they are not in sequence, that is what is left
        else:
            chars[k] = chars[i]
            k = k + 1
            i = i + 1
    return ''.join(chars[:k])
