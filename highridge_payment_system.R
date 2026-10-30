# Highridge Construction Company
# Weekly Worker Payment System

# Set a seed so the same sample data is generated each time
set.seed(42)

# Set the number of workers required by the assignment
number_of_workers <- 400

# Create an empty list to store all workers
workers <- vector("list", number_of_workers)

# Create counters for successful and failed payment slips
successful_slips <- 0
failed_slips <- 0

# Create an empty character vector to store all payment slips
payment_slips <- character(0)

# Create 400 workers dynamically
for (worker_number in 1:number_of_workers) {
  worker_id <- sprintf("HC%03d", worker_number)
  worker_name <- paste("Worker", worker_number)
  gender <- sample(c("Male", "Female"), 1)
  salary <- sample(5000:35000, 1)

  # Combine the worker's information into a list
  worker <- list(
    worker_id = worker_id,
    worker_name = worker_name,
    gender = gender,
    salary = salary
  )

  # Add the worker to the workers list
  workers[[worker_number]] <- worker
}

# Display the company and payment headings
cat("\nHIGHRIDGE CONSTRUCTION COMPANY\n")
cat("WEEKLY PAYMENT SLIPS\n")
cat("==============================\n")

# Generate a payment slip for every worker
for (worker_number in 1:length(workers)) {

  # Process one worker and return TRUE or FALSE
  worker_processed <- tryCatch({

    # Get the current worker from the workers list
    worker <- workers[[worker_number]]

    # Get the worker's information
    worker_id <- worker$worker_id
    worker_name <- worker$worker_name
    gender <- worker$gender
    salary <- worker$salary

    # Check that all required worker information is available
    if (is.null(worker_id) ||
        is.null(worker_name) ||
        is.null(gender) ||
        is.null(salary)) {

      stop("Required worker information is missing.")
    }

    # Check that the salary is a whole number
    if (!is.numeric(salary) || salary %% 1 != 0) {
      stop("Salary must be a whole number.")
    }

    # Check that the salary is greater than zero
    if (salary <= 0) {
      stop("Salary must be greater than zero.")
    }

    # Check that the gender value is valid
    if (!(gender %in% c("Male", "Female"))) {
      stop("Gender must be Male or Female.")
    }

    # Assign Employee level when the worker meets the specific condition
    if (salary > 7500 &&
        salary < 30000 &&
        gender == "Female") {

      employee_level <- "A5-F"

    } else if (salary > 10000 && salary < 20000) {

      employee_level <- "A1"

    } else {

      employee_level <- "Unassigned"
    }

    # Add the employee level to the worker's information
    workers[[worker_number]]$employee_level <- employee_level

    # Format the salary with a comma
    formatted_salary <- format(
      salary,
      big.mark = ",",
      scientific = FALSE,
      trim = TRUE
    )

    # Create the payment slip
    payment_slip <- paste0(
      "Worker ID: ", worker_id, "\n",
      "Worker Name: ", worker_name, "\n",
      "Gender: ", gender, "\n",
      "Weekly Salary: $", formatted_salary, "\n",
      "Employee Level: ", employee_level, "\n",
      "------------------------------"
    )

    # Display the payment slip in the terminal
    cat(payment_slip, "\n")

    # Add the payment slip to the payment slip vector
    payment_slips <- c(payment_slips, payment_slip)

    # Indicate that the worker was processed successfully
    TRUE

  # Handle an error involving the current worker
  }, error = function(error) {

    cat("Worker could not be processed:", conditionMessage(error), "\n")
    cat("------------------------------\n")

    # Indicate that the worker was not processed successfully
    FALSE
  })

  # Update the appropriate counter
  if (worker_processed) {
    successful_slips <- successful_slips + 1
  } else {
    failed_slips <- failed_slips + 1
  }
}

# Create the processing summary
processing_summary <- paste0(
  "\nPROCESSING SUMMARY\n",
  "==============================\n",
  "Total workers: ", length(workers), "\n",
  "Successful payment slips: ", successful_slips, "\n",
  "Failed payment slips: ", failed_slips
)

# Display the processing summary
cat(processing_summary, "\n")

# Add the company heading and summary to the file output
file_output <- c(
  "HIGHRIDGE CONSTRUCTION COMPANY",
  "WEEKLY PAYMENT SLIPS",
  "==============================",
  payment_slips,
  processing_summary
)

# Save all payment slips to a text file
tryCatch({

  writeLines(
    file_output,
    con = "r_payment_slips.txt",
    useBytes = TRUE
  )

  cat("Payment slips saved in r_payment_slips.txt\n")

# Handle an error when writing the text file
}, error = function(error) {

  cat(
    "The payment slip file could not be created:",
    conditionMessage(error),
    "\n"
  )
})