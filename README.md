# PrestaShop_Debug_Docker
## Dockerfile and docker-compose.yml for building and debugging Presta Shop
### Step 1:
- Clone the main Source code from here: https://github.com/PrestaShop/PrestaShop
### Step 2:
- Copy this `Dockerfile` and paste over the `Dockerfile` of PrestaShop
- Copy this `docker-compose.yml` and paste over the `docker-compose.yml` of PrestaShop

### Step 3:
- Copy these 2 config files: `php.ini` and `docker-php-ext-xdebug.ini` and place them in the `config` folder

### Step 4:
- Create a `.vscode` folder (this folder is placed INSIDE the `PrestaShop` folder) contains a `launch.json` file with this content:
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/html": "D:/HPT/CVE/PrestaShop"
            }
        }
    ]
}

```
![alt text](https://raw.githubusercontent.com/khoiminhvo32/PrestaShop_Debug_Docker/main/vscodePic/Screenshot_1.png)
### Step 5:
- Use this command to build up the Project: `docker-compose up`

### Step 6:
- After finish building up the Project, choose a specific `.php` file and press `f5` to debug
