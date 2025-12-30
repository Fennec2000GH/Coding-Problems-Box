// https://leetcode.com/problems/minimum-falling-path-sum-ii/
// adatped from: https://algo.monster/liteproblems/1289

#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<int> dp(n, 0);
        const int INF = 1e9;
      
        for (const auto& row : grid) {
            vector<int> dp_ = row;
          
            for (int c = 0; c < n; c++) {
                int prevMin = INF;
                for (int prev_c = 0; prev_c < n; prev_c++)
                    if (prev_c != c)
                        prevMin = min(prevMin, dp[prev_c]);

                dp_[c] += (prevMin == INF ? 0 : prevMin);
            }

            dp = move(dp_);
        }

        return *min_element(dp.begin(), dp.end());
    }
};
