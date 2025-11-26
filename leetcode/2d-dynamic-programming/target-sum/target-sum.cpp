// ref: https://algo.monster/liteproblems/494

class Solution {
public:
    int findTargetSumWays(vector<int>& nums, int target) {
        // Calculate the total sum of all numbers
        int totalSum = accumulate(nums.begin(), nums.end(), 0);
      
        // Check if target is achievable
        // The difference (totalSum - target) must be non-negative and even
        // because we need to partition nums into two subsets P (positive) and N (negative)
        // where sum(P) - sum(N) = target and sum(P) + sum(N) = totalSum
        // This gives us sum(N) = (totalSum - target) / 2
        if (totalSum < target || (totalSum - target) % 2 != 0) {
            return 0;
        }
      
        int numsSize = nums.size();
        // Calculate the target sum for the negative subset
        int negativeSum = (totalSum - target) / 2;
      
        // dp[i][j] represents the number of ways to select from first i numbers
        // to achieve sum j
        int dp[numsSize + 1][negativeSum + 1];
        memset(dp, 0, sizeof(dp));
      
        // Base case: empty subset has sum 0, there's one way to achieve it
        dp[0][0] = 1;
      
        // Fill the dp table
        for (int i = 1; i <= numsSize; ++i) {
            for (int j = 0; j <= negativeSum; ++j) {
                // Case 1: Don't include current number
                dp[i][j] = dp[i - 1][j];
              
                // Case 2: Include current number if possible
                if (j >= nums[i - 1]) {
                    dp[i][j] += dp[i - 1][j - nums[i - 1]];
                }
            }
        }
      
        // Return the number of ways to achieve the negative subset sum
        return dp[numsSize][negativeSum];
    }
};

