class Solution:
    def combinationSum(self, candidates, target):
        retval = []
        for next_considered in candidates:
            self.dfs(target, next_considered, candidates, [], retval)
        return retval

    def dfs(self, target, considered, candidates, subset, retval):
        new_target = target - considered
        import pdb;pdb.set_trace()

        if (new_target < 0):
            return
        elif (new_target == 0):
            subset.append(considered)
            retval.append(subset)
            return
        else:
            ## copy array into new set, pass new subset into the recursive call.
            subset.append(considered)
            next_considered in candidates:
                self.dfs(new_target, next_considered, candidates, subset, retval)

        return retval
