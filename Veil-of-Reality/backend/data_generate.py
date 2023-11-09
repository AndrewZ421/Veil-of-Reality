import csv
import pycountry

from faker import Faker

# Instantiate a Faker object
fake = Faker()

# Get the list of available locales
available_locales = sorted([locale for locale in fake._factories])

# Print the list of locales
locale_dict = available_locales[0].providers[1].language_locale_codes

# Create a list to hold the combined locale codes
combined_locale_codes = []

# Iterate over the dictionary and combine language and country codes
for lang_code, country_codes in locale_dict.items():
    for country_code in country_codes:
        combined_locale_codes.append(f"{lang_code}-{country_code}")

# Print the result
print(combined_locale_codes)

support_countries = []
for combined_locale_code in combined_locale_codes:
    try:
        print(Faker(combined_locale_code).name())
        support_countries.append(combined_locale_code)
    except AttributeError:
        continue

print(support_countries)

# Prepare the data for CSV
csv_data = []

for locale in support_countries:
    # Split the locale string to get the language and country code
    _, country_code = locale.split('-')

    # Get the country object from pycountry
    country = pycountry.countries.get(alpha_2=country_code)

    # Prepare the row for CSV
    row = {
        'Original Code': locale,
        'Country Code': country_code,
        'Country Name': country.name if country else None
    }

    # Add to the data list
    csv_data.append(row)

# Specify the CSV file name
csv_file_name = 'data/country_codes.csv'

# Write the data to the CSV file
with open(csv_file_name, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.DictWriter(file, fieldnames=['Original Code', 'Country Code', 'Country Name'])
    writer.writeheader()
    for data in csv_data:
        writer.writerow(data)

print(f'Data written to {csv_file_name}')
