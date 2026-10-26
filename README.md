JIA MANAGEMENT SYSTEM
 
ER Diagram 
<img width="4512" height="1902" alt="ER_AMS" src="https://github.com/user-attachments/assets/a91f3b75-2fa5-43cf-8907-afec3ef9e0ec" />
Relational Schema
<img width="4512" height="1902" alt="SchemaAMS" src="https://github.com/user-attachments/assets/7c66a9c3-8813-43a5-9938-f71aac1b674c" />

PROJECT IMAGES
<img width="1917" height="1020" alt="Image" src="https://github.com/user-attachments/assets/3e6c259a-9817-4696-80f9-a36bd67d9aca" />
<img width="1917" height="1015" alt="Image" src="https://github.com/user-attachments/assets/c4a77fab-7106-4234-9c21-b0e7bc6953dd" />
<img width="1917" height="1017" alt="Image" src="https://github.com/user-attachments/assets/ac9eb9cb-af6f-4838-9b58-dc71b1ee0ac9" />
<img width="1917" height="1017" alt="Image" src="https://github.com/user-attachments/assets/e81e3897-c768-49dc-abc9-e95de04e0870" />
<img width="1917" height="1016" alt="Image" src="https://github.com/user-attachments/assets/13efd659-ede6-4b62-b1af-28631fb1ca80" />
<img width="1917" height="1017" alt="Image" src="https://github.com/user-attachments/assets/4675c667-e07c-4d04-9a2e-76a66443189f" />
<img width="1917" height="1016" alt="Image" src="https://github.com/user-attachments/assets/f798ec5e-4dc3-48c4-9b48-8109706339fd" />
<img width="1917" height="1020" alt="Image" src="https://github.com/user-attachments/assets/64263df7-7204-40d0-b800-9b01173b0140" />
<img width="1917" height="1017" alt="Image" src="https://github.com/user-attachments/assets/7538d237-ad52-4626-8152-3654d9998741" />
<img width="1917" height="1012" alt="Image" src="https://github.com/user-attachments/assets/db456790-f33d-4406-b763-483a2e0410dc" />
<img width="1617" height="792" alt="Image" src="https://github.com/user-attachments/assets/3ce5f23f-90d0-409f-80c4-312b559c10d5" />
<img width="1916" height="1020" alt="Image" src="https://github.com/user-attachments/assets/24d7f676-fe5d-414a-8bda-f9f5a66e9f71" />

DOWNLOAD AND SETUP INSTRUCTIONS
A self-contained desktop build of the Airport Management System. Unzip and run — **no Java required** (a private Java runtime is bundled).

> **Note:** the app needs a running **MySQL server**. That's the only thing you install yourself; everything else ships in the zip.

---

## Requirements

- **Windows 10/11 (64-bit)**
- **MySQL Server** (Community Server, or MySQL bundled with XAMPP/WAMP)
- No Java / JDK needed

---

## Setup (≈5 minutes)

### 1. Install MySQL
Download and install [MySQL Community Server](https://dev.mysql.com/downloads/mysql/), **or** use the MySQL that ships with XAMPP / WAMP. Remember the root password you set.

### 2. Create the database
Import the schema included in the zip (`airport_management_schema.sql`). It creates the `airport_management` database **and** loads sample flights, airlines, passengers and bookings.

From a terminal:
```
mysql -u root -p < airport_management_schema.sql
```
…or in **MySQL Workbench**: open the `.sql` file and run it.

### 3. Edit `db.properties`
Open `db.properties` (in Notepad) in the same folder as `AirportMS.exe` and set the three values to match **your** MySQL setup:
```
db.url=jdbc:mysql://localhost:3306/airport_management
db.user=root
db.password=YOUR_MYSQL_PASSWORD
```
Save the file.

---

## Run it

Double-click:
```
Launch Airport Management System.bat
```
(or double-click `AirportMS.exe` directly.)

**First run:** Windows may show *"Windows protected your PC."* Click **More info → Run anyway.** That's normal for an app that isn't code-signed.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| *Communications link failure* / can't connect | MySQL isn't running, **or** `db.url` host/port is wrong, **or** `db.user`/`db.password` are wrong. |
| *Unknown database 'airport_management'* | You skipped step 2 — import `airport_management_schema.sql`. |
| App can't find `db.properties` | Keep `db.properties` in the **same folder** as `AirportMS.exe`. The `Launch ... .bat` handles this automatically. |

---

## What's in the zip

| File | Purpose |
|---|---|
| `AirportMS.exe` | The application |
| `Launch Airport Management System.bat` | Safe launcher (sets the working folder) |
| `db.properties` | Database settings — **edit me** |
| `airport_management_schema.sql` | Database schema + sample data |
| `README - Setup.txt` | The same instructions, offline |
| `app\` , `runtime\` | App code + bundled Java runtime (leave alone) |

---

**Full source:** see the *Source code* assets on this release, or the repository.
