# Highridge Construction Company
# Weekly Worker Payment System

# Import the random module for generating sample worker information
import random

# Set a seed so the same sample data is generated each time
random.seed(42)

# Create an empty list to store all workers
workers = []

# Set the number of workers to generate
number_of_workers = 400

# Create counters for successful and failed payment slips
successful_slips = 0
failed_slips = 0

# Create 400 workers dynamically
for worker_number in range(1, number_of_workers + 1):
    worker_id = f"HC{worker_number:03}"
    worker_name = f"Worker {worker_number}"
    gender = random.choice(["Male", "Female"])
    salary = random.randint(5000, 35000)
# Combine the worker's information into a dictionary
    worker = {
        "worker_id": worker_id,
        "worker_name": worker_name,
        "gender": gender,
        "salary": salary 
    }
    # Add the worker dictionary to the workers list
    workers.append(worker)

# Display the company and payment headings
print("\nHighridge Construction Company")
print("WEEKLY PAYMENT SLIP")
print("==============================")

try:
    # Create and open the payment slip file
    with open("python_payment_slips.txt", "w", encoding="utf-8") as payment_file:

        # Write the company heading to the text file
        payment_file.write("HIGHRIDGE CONSTRUCTION COMPANY\n")
        payment_file.write("WEEKLY PAYMENT SLIPS\n")
        payment_file.write("==============================\n")

        # Generate a payment slip for each worker
        for worker in workers:

            try:
                # Get the worker's information from the dictionary
                worker_id = worker["worker_id"]
                worker_name = worker["worker_name"]
                gender = worker["gender"]
                salary = worker["salary"]

                # Check that the salary is a whole number
                if not isinstance(salary, int):
                    raise TypeError("Salary must be a whole number.")

                # Check that the salary is greater than zero
                if salary <= 0:
                    raise ValueError("Salary must be greater than zero.")

                # Check that the gender value is valid
                if gender not in ["Male", "Female"]:
                    raise ValueError("Gender must be Male or Female.")
        
                # Assign Employee level when the worker meets the specific condition
                if 7500 < salary < 30000 and gender == "Female":
                    employee_level = "A5-F"
                elif 10000 < salary < 20000:
                    employee_level = "A1"
                else:
                    employee_level = "Unassigned"
                worker["employee_level"] = employee_level

                # Create the payment slip
                payment_slip = (
                    f"Worker ID: {worker_id}\n"
                    f"Worker Name: {worker_name}\n"
                    f"Gender: {gender}\n"
                    f"Weekly Salary: ${salary:,}\n"
                    f"Employee Level: {employee_level}\n"
                    f"------------------------------\n"
                )
                # Display the payment slip in the VS Code terminal
                print(payment_slip, end="")

                # Save the payment slip in the text file
                payment_file.write(payment_slip)

                # Increase the successful payment slip count
                successful_slips += 1

            # Handle missing information in a worker dictionary
            except KeyError as error:
                failed_slips += 1
                print(f"Missing worker information: {error}")
                print("This worker could not be processed.")
                print("------------------------------")

            # Handle an incorrect data type
            except TypeError as error:
                failed_slips += 1
                print(f"Invalid data type: {error}")
                print("This worker could not be processed.")
                print("------------------------------")

            # Handle an invalid value
            except ValueError as error:
                failed_slips += 1
                print(f"Invalid worker value: {error}")
                print("This worker could not be processed.")
                print("------------------------------")

            # Handle any other unexpected worker error
            except Exception as error:
                failed_slips += 1
                print(f"An unexpected error occurred: {error}")
                print("This worker could not be processed.")
                print("------------------------------")

        # Write the processing summary to the text file
        payment_file.write("\nPROCESSING SUMMARY\n")
        payment_file.write("==============================\n")
        payment_file.write(f"Total workers: {len(workers)}\n")
        payment_file.write(f"Successful payment slips: {successful_slips}\n")
        payment_file.write(f"Failed payment slips: {failed_slips}\n")

# Handle an error when creating or writing to the text file
except OSError as error:
    print(f"\nThe payment slip file could not be created: {error}")

# Display the final processing summary
print("\nPROCESSING SUMMARY")
print("==============================")
print(f"Total workers: {len(workers)}")
print(f"Successful payment slips: {successful_slips}")
print(f"Failed payment slips: {failed_slips}")
print("Payment slips saved in python_payment_slips.txt")