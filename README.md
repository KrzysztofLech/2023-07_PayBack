July 2023

# PAYBACK Coding Challenge

Note: **Xcode version 15** or higher is required to test the task.

The main goal of the task is to display a list of transactions and the corresponding details screen for each of them.

## Requirements

Please create a SwiftUI App based on the following User-Stories:

* As a user of the App, I want to see a list of (mocked) transactions. Each item in the list displays `bookingDate`, `partnerDisplayName`, `transactionDetail.description`, `value.amount` and `value.currency`. *(attached JSON File)*
* As a user of the App, I want to have the list of transactions sorted by `bookingDate` from newest (top) to oldest (bottom).
* As a user of the App, I want to get feedback when loading of the transactions is ongoing or an Error occurs. *(Just delay the mocked server response for 1-2 seconds and randomly fail it)*
* As a user of the App, I want to see an error if the device is offline.
* As a user of the App, I want to filter the list of transactions by `category`.
* As a user of the App, I want to see the sum of filtered transactions somewhere on the Transaction-list view. *(Sum of `value.amount`)*
* As a user of the App, I want to select a transaction and navigate to its details. The details-view should just display `partnerDisplayName` and `transactionDetail.description`.
* As a user of the App, I like to see nice UI in general. However, for this coding challenge fancy UI is not required.

## Task implementation

* **SwiftUI + Combine** (MVVM + Coordinators architecture)
* Codable, Network Reachability, error handling
* multilanguages supporting
	* strings localization
	* dates in local format
	* supporting for different currency symbols
* used new **Xcode 15 features**:
	* images and colours used in form of the resources enum list (Auto “Enumed” Asset Catalog)
	* *String Catalog* used to store keys needed to localization
	* Previews
