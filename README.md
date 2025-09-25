# RAP Application on Cloud Environment (Managed Scenario with Draft)

This project demonstrates a RAP (RESTful ABAP Programming Model) application built on the SAP BTP ABAP Environment using the **Managed Scenario** with **Draft functionality enabled**.  
The implementation includes unmanaged numbering, value helps, validation logic, and calculated fields.

---

## Features Implemented

- **RAP Application with Draft**  
  Built on the SAP BTP ABAP Environment using the Managed scenario with Draft enabled for create, edit, and delete operations.  
  ![Initial Report](./img/1.%20Initial%20Report.png)

- **Unmanaged Numbering (Early Number Assignment)**  
  Implemented early numbering for billing documents in a managed scenario.  
  ![Unmanaged numbering](./2.%20Unmanaged%20numbering%20in%20Managed%20Scenario.png)

- **Value Helps + Draft Support**  
  Added value helps for selecting customers and other fields with draft handling out of the box.  
  ![Value Help](./3.%20Value%20Help%20+%20Draft%20Functionality.png)

- **Unmanaged Numbering at Item Level**  
  Item numbers are also assigned using unmanaged logic, ensuring unique numbering.  
  ![Unmanaged numbering item level](./4.%20Unmanaged%20numbering%20az%20Item%20level.png)

- **Validation on Currency**  
  Implemented a check to allow only **EUR** as currency. An error message is shown if another currency is used.  
  ![Currency Validation](./5.%20Validation%20on%20Currency.png)

- **Net Amount Calculation**  
  The **Net Amount** at root entity level is automatically calculated as the sum of all item amounts.  
  ![Draft Handling](./6.%20Draft%20Handling%20out%20of%20box.png)

---

## Repository
👉 [rap_app_on_cloud_environment](https://github.com/rimo-de/rap_app_on_cloud_environment.git)



