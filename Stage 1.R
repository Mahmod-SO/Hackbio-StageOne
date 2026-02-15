gc_calculator <- function(input_gene) {
  input_gene <- strsplit(x = input_gene, split = "")[[1]]
  print(length(input_gene))
  
  #core operation
  gc_counter <- 0  # initialize with zero
  for (nucleotide in input_gene) { # for loop
    print(nucleotide)
    
    if (nucleotide == 'G' | nucleotide == 'C' | nucleotide == 'c' | nucleotide == 'g' ) { # if statement
      gc_counter = gc_counter + 1 # operation
    } 
  }
  
  return(gc_counter/length(input_gene) * 100)
  
}




protein_weight <- function() {
  seq_input <- readline(prompt = "Enter protein sequence: ")
  seq_input <- toupper(seq_input) 
  
  weights <- c(
    A = 89.09, R = 174.20, N = 132.12, D = 133.10, C = 121.15, E = 147.13, 
    Q = 146.15, G = 75.07, H = 155.16, I = 131.18, L = 131.18, K = 146.19,
    M = 149.21, F = 165.19, P = 115.13, S = 105.09, T = 119.12, W = 204.23, Y = 181.19, V = 117.15
  )
  
  sequence <- strsplit(seq_input, split = "")[[1]]
  
  if (any(!(sequence %in% names(weights)))) {
    print(0)
  } else {
    total_weight <- sum(weights[sequence])
    total_kDa <- total_weight / 1000
    print(paste("Protein_Weight:", total_kDa, "kDa"))
  }
}

protein_weight()

