
class UnionFind {
public:
    UnionFind(int n) {
        parent = vector<int>(n);
        rank = vector<int>(n, 1);
        iota(parent.begin(), parent.end(), 0);
    }

    bool unite(int a, int b) {
        int rootA = find(a);
        int rootB = find(b);
      
        if (rootA == rootB) {
            return false;
        }

        if (rank[rootA] > rank[rootB]) {
            parent[rootB] = rootA;
            rank[rootA] += rank[rootB];
        } else {
            parent[rootA] = rootB;
            rank[rootB] += rank[rootA];
        }
        return true;
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

private:
    vector<int> parent;
    vector<int> rank;
};

class Solution {
public:
    vector<vector<string>> accountsMerge(vector<vector<string>>& accounts) {
        int numAccounts = accounts.size();
        UnionFind unionFind(numAccounts);
        unordered_map<string, int> emailToAccountIndex;
      
        for (int i = 0; i < numAccounts; ++i) {
            for (int j = 1; j < accounts[i].size(); ++j) {
                const string& email = accounts[i][j];
                if (emailToAccountIndex.find(email) != emailToAccountIndex.end()) {
                    unionFind.unite(i, emailToAccountIndex[email]);
                } else {
                    emailToAccountIndex[email] = i;
                }
            }
        }
      
        unordered_map<int, set<string>> rootToEmails;
        for (int i = 0; i < numAccounts; ++i) {
            int rootAccount = unionFind.find(i);
            rootToEmails[rootAccount].insert(accounts[i].begin() + 1, accounts[i].end());
        }
      
        vector<vector<string>> mergedAccounts;
        for (const auto& [rootAccount, emailSet] : rootToEmails) {
            vector<string> accountData(emailSet.begin(), emailSet.end());
            accountData.insert(accountData.begin(), accounts[rootAccount][0]);
            mergedAccounts.push_back(accountData);
        }
      
        return mergedAccounts;
    }
};
