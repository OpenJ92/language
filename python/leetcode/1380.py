class Solution:
    def luckyNumbers (self, matrix: List[List[int]]) -> List[int]:

        m = len(matrix[0])
        n = len(matrix)

        rows = matrix
        cols = list(map(list, list(zip(*matrix))))

        return list(set(map(min, rows)).intersection(set(map(max, cols))))
