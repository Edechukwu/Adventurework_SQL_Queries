# Adventurework_SQL_Queries
<!-- PROJECT SHIELD -->
![License](https://img.shields.io/badge/license-MIT-green)

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h3 align="center">AdventureWorks_SQL_Queries</h3>

  <p align="center">
  A series of SQL queries crafted to analyze and extract key insights from the AdventureWorks database, focusing on product pricing, employee performance, and sales trends.
    <br />
    <a href="#usage"><strong>Explore the queries »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Edechukwu/AdventureWorks-SQL-Queries">View Demo</a>
    ·
    <a href="https://github.com/Edechukwu/AdventureWorks-SQL-Queries/issues">Report Bug</a>
    ·
    <a href="https://github.com/Edechukwu/AdventureWorks-SQL-Queries/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

- [About the Project](#about-the-project)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [License](#license)
- [Contact](#contact)

<!-- ABOUT THE PROJECT -->
## About The Project

This project highlights a series of SQL queries tailored for the **AdventureWorks** sample database. The queries address essential business scenarios, including product pricing analysis, employee performance evaluation, and sales trend identification, serving as a practical application of SQL techniques such as `JOINs`, `CASE` statements, window functions, and common table expressions.
### Built With

* [Microsoft SQL Server (MSSQL)](https://www.microsoft.com/en-us/sql-server)
* [AdventureWorks Database](https://docs.microsoft.com/en-us/sql/samples/adventureworks)
* [SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms) <!-- GETTING STARTED -->
## Getting Started

To get a local copy of the project and run the queries, follow these steps.

### Prerequisites

Ensure you have the following installed:
* Microsoft SQL Server (MSSQL).
* AdventureWorks sample database.
* SQL Server Management Studio (SSMS) for querying.

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/Edechukwu/AdventureWorks-SQL-Queries.git
   ```
2. Restore the AdventureWorks database:
   [Instructions for AdventureWorks database installation](https://docs.microsoft.com/en-us/sql/samples/adventureworks)

<!-- USAGE EXAMPLES -->
## Usage

The repository contains SQL queries to address various business questions. Below are some examples: 
1. **Sales Performance by Region**:
   - Analyzes total sales revenue grouped by region. This query sums up the sales amounts and groups the results by the sales territory.  
   ```sql
  SELECT st.Name AS Region, SUM(SOH.TotalDue) AS TotalRevenue FROM Sales.SalesOrderHeader AS SOH
JOIN Sales.SalesTerritory AS st ON so.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalRevenue DESC;
   ```

## Contributing

The open-source community is an incredible place to learn, be inspired, and develop because of contributions. Any contributions you make to this SQL project will be much appreciated.

### How to Contribute:

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/NewFeature`).
3. Commit your changes (`git commit -m 'Add NewFeature'`).
4. Push to the branch (`git push origin feature/NewFeature`).
5. Open a pull request for review.

### Reporting Issues:
If you encounter any issues with the queries or have suggestions for improvement, please feel free to open an issue with a detailed description of the problem.

     <!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

IFEOMA EDECHUKWU - [iedechukwu@gmail.com](mailto:iedechukwu@gmail.com)  
GitHub: [https://github.com/Edechukwu](https://github.com/Edechukwu)

Project Link: [https://github.com/Edechukwu/AdventureWorks-SQL-Queries](https://github.com/Edechukwu/AdventureWorks-SQL-Queries)
