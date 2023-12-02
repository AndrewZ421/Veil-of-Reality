import pandas as pd
# Re-import the CSV file to start fresh
df = pd.read_csv("./events.csv")

# Function to handle choices as string and convert them to list
def handle_choices(choices_str):
    # Converting the string representation of list to an actual list
    choices_list = choices_str.strip("[]").replace("'", "").split(", ")
    # Add a choice if there are only three
    if len(choices_list) == 3:
        choices_list.append("Seek advice")
    # Shorten each choice
    return choices_list

# Apply the handle_choices function to the 'choices' column
df['choices'] = df['choices'].apply(handle_choices)

# Display the first few rows to verify the changes
df.head()

# Save the dataframe to a new CSV file
df.to_csv("./format_events.csv", index=False)
