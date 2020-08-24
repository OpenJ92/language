class Solution:
    def pacificAtlantic(self, matrix):
        if not matrix:
            return None
        rows = len(matrix)
        cols = len(matrix[0])
        atlantic = [[False for _ in range(cols)] for _ in range(rows)]
        pacific = [[False for _ in range(cols)] for _ in range(rows)]

        for row in range(rows):
            self.dfs(atlantic, matrix, (row, 0))
            self.dfs(pacific, matrix, (row, cols-1))

        for col in range(cols):
            self.dfs(atlantic, matrix, (0, col))
            self.dfs(pacific, matrix, (rows-1, col))

        return self.intersect(atlantic, pacific, rows, cols)


    def dfs(self, can_reach, heights, considered):
        moves = self.get_moves(heights, *considered)
        import pdb;pdb.set_trace()
        height = self.access_mat(heights, *considered)
        self.set_mat(can_reach, *considered, True)

        for move in moves:
            if move \
            and self.is_valid(considered, move, height, heights) \
            and self.has_not_visited(considered, move, can_reach):
                self.dfs(can_reach, heights, self.sum_indices(considered, move))

        return None

    def access_mat(self, mat, x, y):
        return mat[y][x]

    def set_mat(self, mat, x, y, val):
        mat[y][x] = val

    def get_moves(self, mat, x, y):
        up    = [-1,0]   if x > 0               else None
        down  = [1, 0]   if x < len(mat[0]) - 1    else None
        left  = [0,-1]   if y > 0               else None
        right = [0, 1]   if y < len(mat) - 1 else None
        return up, down, left, right

    def is_valid(self, considered, move, height, mat):
        return self.access_mat(mat, *self.sum_indices(considered, move)) >= height

    def has_not_visited(self, considered, move, mat):
        return self.access_mat(mat, *self.sum_indices(considered, move)) == False

    def sum_indices(self, ind1, ind2):
        return [i + j for i, j in zip(ind1, ind2)]

    def intersect(self, atlantic, pacific, rows, cols):
        queue = []
        for i in range(rows):
            for j in range(cols):
                if self.access_mat(atlantic, i, j) and self.access_mat(pacific, i, j):
                    queue.append(list((j, i)))
        return queue
