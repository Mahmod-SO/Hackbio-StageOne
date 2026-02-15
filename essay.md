# How I Built My Protein Weight Calculator in R

## Overview

For this assignment, I needed to create a function that calculates the molecular weight of protein sequences in kiloDaltons. The function had to return 0 if any non-standard amino acid characters were detected. Here's how I approached the problem step by step.

## Step 1: Making It Interactive

I decided to use `readline()` to make the function interactive instead of passing parameters:

```r
protein_weight <- function() {
  seq_input <- readline(prompt = "Enter protein sequence: ")
```

This made my tool more user-friendly since I could just run it and type in sequences directly, which felt more natural for the task at hand.

## Step 2: Handling Different Cases

The first thing I did after getting input was convert everything to uppercase using `toupper()`:

```r
seq_input <- toupper(seq_input)
```

I knew that sequences could be typed in lowercase, uppercase, or mixed case, so normalizing everything to uppercase from the start would prevent any issues later. This way "protein" and "PROTEIN" would be treated the same.

## Step 3: Creating the Weight Lookup Table

I created a named vector containing all 20 standard amino acids and their molecular weights from the provided table:

```r
weights <- c(
  A = 89.09, R = 174.20, N = 132.12, D = 133.10, C = 121.15, E = 147.13, 
  Q = 146.15, G = 75.07, H = 155.16, I = 131.18, L = 131.18, K = 146.19,
  M = 149.21, F = 165.19, P = 115.13, S = 105.09, T = 119.12, W = 204.23, 
  Y = 181.19, V = 117.15
)
```

I chose a named vector because it lets me look up weights by amino acid letter directly (like `weights["A"]`), which is perfect for this task.

## Step 4: Breaking Down the Sequence

Next, I needed to split the input string into individual characters:

```r
sequence <- strsplit(seq_input, split = "")[[1]]
```

Using `split = ""` splits the string at every character. The `[[1]]` extracts the result from the list that `strsplit()` returns. Now I had a vector where each element was one amino acid letter.

## Step 5: Validating the Input

This was the key part - checking if all characters are valid amino acids:

```r
if (any(!(sequence %in% names(weights)))) {
  print(0)
}
```

Here's what this does:
- `sequence %in% names(weights)` checks each character against valid amino acids
- The `!` negates it to find *invalid* characters
- `any()` returns TRUE if there's at least one invalid character
- If found, I print 0 as required

This approach checks the entire sequence at once using R's vectorized operations, which is much faster than looping through character by character.

## Step 6: Calculating the Weight

If validation passes, I calculate the total weight:

```r
total_weight <- sum(weights[sequence])
```

This is where R really shines. By using `weights[sequence]`, R looks up the weight for each amino acid in my sequence vector and returns a new vector of weights. Then `sum()` adds them all up. This single line replaces what would be a whole loop in other languages.

## Step 7: Converting to KiloDaltons

The final calculation converts Daltons to kiloDaltons:

```r
total_kDa <- total_weight / 1000
print(paste("Protein_Weight:", total_kDa, "kDa"))
```

I divided by 1000 to convert from Da to kDa, which is the standard unit for protein weights. Then I used `paste()` to create a clear, labeled output showing both the value and the unit.

## Challenges I Faced

The trickiest part was getting the validation logic right. At first, I considered using a loop to check each character, but then I realized R's vectorized operations could do it all at once with `any(!(sequence %in% names(weights)))`. This was more elegant and efficient.

I also had to remember that `strsplit()` returns a list, so I needed the `[[1]]` to extract the actual character vector.

## What I Learned

This project taught me the power of R's vectorized operations. Instead of thinking in terms of loops, I learned to think about transforming entire vectors at once. The combination of named vectors for lookup and vectorized operations made the code remarkably concise - just about 15 lines total.

I also learned to handle user input properly with `readline()` and `toupper()`, making the function robust enough to handle real-world messy data.

## Conclusion

My solution successfully calculates protein molecular weights while handling invalid characters as required. The use of R's vectorized operations made the code both efficient and readable. While the function could be enhanced with more detailed error messages or additional features, it effectively solves the core problem in a clean, straightforward way.
