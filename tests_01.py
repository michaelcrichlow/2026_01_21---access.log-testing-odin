from collections import Counter

# 1. Get lines (Python's version of your get_lines_from_file)
with open("access.log", "r") as f:
    lines = f.readlines()

# 2. Filter (The "Lines Filtered" logic)
# This says: "Take the URL (part index 1) for every line if the status is 200"
success_urls = [line.split()[1] for line in lines if line.startswith("200")]

# 3. Count and Sort
counts = Counter(success_urls)
top_5 = counts.most_common(5)

# 4. Print
for url, count in top_5:
    print(url, count)