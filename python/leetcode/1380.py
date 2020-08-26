class Solution:
    def luckyNumbers (self, matrix):

        m = len(matrix[0])
        n = len(matrix)

        rows = matrix
        cols = list(map(list,zip(*matrix)))

        return list(set(map(min, rows)).intersection(set(map(max, cols))))
