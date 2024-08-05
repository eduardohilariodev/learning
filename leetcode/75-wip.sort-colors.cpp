
#include <vector>
#include <iostream>
using namespace std;

class Solution
{
public:
  void sortColors(vector<int> &nums)
  {
    const int bucketSize = 3;
    int counts[bucketSize] = {0, 0, 0};

    // count the number of individual values
    for (int i = 0; i < nums.size(); i++)
    {
      int n = nums[i];
      counts[n] += 1;
    }

    // the i pointer tell where to fill the value on nums
    int i = 0;

    // n iterates of each index of counts
    for (int n = 0; n < bucketSize; n++)
    {
      // j iterates n many times on the nums
      for (int j = 0; j < counts[n]; j++)
      {
        nums[i] = n;
        i += 1;
      }
    }
  }
};

int main()
{
  Solution solution;
  vector<int> nums = {2, 0, 2, 1, 1, 0};

  cout << "Before sorting: ";
  for (int num : nums)
  {
    cout << num << " ";
  }
  cout << endl;

  solution.sortColors(nums);

  cout << "After sorting: ";
  for (int num : nums)
  {
    cout << num << " ";
  }
  cout << endl;

  return 0;
}
