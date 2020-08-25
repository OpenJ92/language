class Solution:
    def pacificAtlantic(self, matrix):

        if not matrix:
            return None

        rows = len(matrix)
        cols = len(matrix[0])

        atlantic = [[False for _ in range(cols)] for _ in range(rows)]
        pacific  = [[False for _ in range(cols)] for _ in range(rows)]

        for row in range(rows):
            self.dfs(atlantic, matrix, row, 0)
            self.dfs(pacific,  matrix, row, cols-1)

        for col in range(cols):
            self.dfs(atlantic, matrix, 0, col)
            self.dfs(pacific, matrix, rows-1, col)

        queue = []
        for i in range(rows):
            for j in range(cols):
                if atlantic[i][j] and pacific[i][j]:
                    queue.append([i, j])
        return queue

    def dfs(self, can_reach, heights, row, col):

        moves = self.get_moves(heights, row, col)

        height = heights[row][col]
        can_reach[row][col] = True

        for move in moves:
            if  move \
            and heights[row+move[0]][col+move[1]]   >= height \
            and can_reach[row+move[0]][col+move[1]] == False:
                self.dfs(can_reach, heights, row+move[0], col+move[1])

        return None

    def get_moves(self, mat, x, y):
        up    = [-1,0]   if x > 0               else None
        down  = [1, 0]   if x < len(mat) - 1.   else None
        left  = [0,-1]   if y > 0               else None
        right = [0, 1]   if y < len(mat[0]) - 1 else None
        return up, down, left, right
