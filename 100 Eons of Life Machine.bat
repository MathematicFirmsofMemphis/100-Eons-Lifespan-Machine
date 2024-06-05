@echo off
title 100-Eon Lifespan Management System
color 0A

:: Initial balances and settings
set eon_balance=100
set Anatomy_Levels_of_Pure_Super_Hydrogen_balance=50
set reverse_aging=0
set reverse_aging_eons=0

:main_menu
cls
echo ==================================================
echo              Welcome to the 100-Eon Lifespan Management System
echo           Powered by Dry Humidifiers and Liquid Hydrogen Technology
echo ==================================================
echo 1. Login
echo 2. Exit
echo ==================================================
set /p choice="Please choose an option (1-2): "

if "%choice%"=="1" goto login
if "%choice%"=="2" goto exit
echo Invalid choice. Please try again.
pause
goto main_menu

:login
cls
set /p user="Enter Username: "
set /p pass="Enter Password: "
echo Authenticating...
:: Simulating a database check for username and password
if "%user%"=="admin" if "%pass%"=="password" (
    echo Authentication successful!
    pause
    goto account_menu
) else (
    echo Invalid username or password. Please try again.
    pause
    goto main_menu
)

:account_menu
cls
echo ==================================================
echo                 Account Menu
echo ==================================================
echo 1. Check Eon Balance
echo 2. Recharge Eons
echo 3. Use Eons
echo 4. Check Anatomy_Levels_of_Pure_Super_Hydrogen Balance
echo 5. Recharge Anatomy_Levels_of_Pure_Super_Hydrogen
echo 6. Use Anatomy_Levels_of_Pure_Super_Hydrogen
echo 7. Enable Reverse Aging
echo 8. Disable Reverse Aging
echo 9. Log Out
echo ==================================================
set /p acc_choice="Please choose an option (1-9): "

if "%acc_choice%"=="1" goto check_eon_balance
if "%acc_choice%"=="2" goto recharge_eons
if "%acc_choice%"=="3" goto use_eons
if "%acc_choice%"=="4" goto check_Anatomy_Levels_of_Pure_Super_Hydrogen_balance
if "%acc_choice%"=="5" goto recharge_Anatomy_Levels_of_Pure_Super_Hydrogen
if "%acc_choice%"=="6" goto use_Anatomy_Levels_of_Pure_Super_Hydrogen
if "%acc_choice%"=="7" goto enable_reverse_aging
if "%acc_choice%"=="8" goto disable_reverse_aging
if "%acc_choice%"=="9" goto main_menu
echo Invalid choice. Please try again.
pause
goto account_menu

:check_eon_balance
cls
set /a years=%eon_balance%*1000000000
if %reverse_aging%==1 (
    set /a total_eons=%eon_balance%+%reverse_aging_eons%
    set /a total_years=%total_eons%*1000000000
    echo Your current eon balance is: %total_eons% eons (%total_years% years) [Reverse Aging Enabled]
) else (
    echo Your current eon balance is: %eon_balance% eons (%years% years)
)
pause
goto account_menu

:recharge_eons
cls
set /p recharge="Enter eons to recharge: "
:: Check if recharge is a valid number
echo %recharge% | findstr /r "^[0-9]*$" >nul
if errorlevel 1 (
    echo Invalid input. Please enter a valid numeric value.
    pause
    goto recharge_eons
)
set /a eon_balance+=recharge
set /a years=%eon_balance%*1000000000
echo You have successfully recharged %recharge% eons.
echo Your new balance is: %eon_balance% eons (%years% years)
pause
goto account_menu

:use_eons
cls
set /p use="Enter eons to use: "
:: Check if use is a valid number
echo %use% | findstr /r "^[0-9]*$" >nul
if errorlevel 1 (
    echo Invalid input. Please enter a valid numeric value.
    pause
    goto use_eons
)
if %reverse_aging%==1 (
    set /a total_eons=%eon_balance%+%reverse_aging_eons%
    if %use% gtr %total_eons% (
        echo Insufficient eons.
        pause
        goto account_menu
    ) else (
        set /a remaining_use=%use%
        if %remaining_use% leq %reverse_aging_eons% (
            set /a reverse_aging_eons-=%remaining_use%
        ) else (
            set /a remaining_use-=%reverse_aging_eons%
            set /a reverse_aging_eons=0
            set /a eon_balance-=%remaining_use%
        )
    )
) else (
    if %use% gtr %eon_balance% (
        echo Insufficient eons.
        pause
        goto account_menu
    ) else (
        set /a eon_balance-=%use%
    )
)
set /a years=%eon_balance%*1000000000
echo You have successfully used %use% eons.
echo Your new balance is: %eon_balance% eons (%years% years)
pause
goto account_menu

:check_Anatomy_Levels_of_Pure_Super_Hydrogen_balance
cls
echo Your current Anatomy_Levels_of_Pure_Super_Hydrogen balance is: %Anatomy_Levels_of_Pure_Super_Hydrogen_balance% levels
pause
goto account_menu

:recharge_Anatomy_Levels_of_Pure_Super_Hydrogen
cls
set /p recharge="Enter Anatomy_Levels_of_Pure_Super_Hydrogen levels to recharge: "
:: Check if recharge is a valid number
echo %recharge% | findstr /r "^[0-9]*$" >nul
if errorlevel 1 (
    echo Invalid input. Please enter a valid numeric value.
    pause
    goto recharge_Anatomy_Levels_of_Pure_Super_Hydrogen
)
set /a Anatomy_Levels_of_Pure_Super_Hydrogen_balance+=recharge
echo You have successfully recharged %recharge% Anatomy_Levels_of_Pure_Super_Hydrogen levels.
echo Your new balance is: %Anatomy_Levels_of_Pure_Super_Hydrogen_balance% levels
pause
goto account_menu

:use_Anatomy_Levels_of_Pure_Super_Hydrogen
cls
set /p use="Enter Anatomy_Levels_of_Pure_Super_Hydrogen levels to use: "
:: Check if use is a valid number
echo %use% | findstr /r "^[0-9]*$" >nul
if errorlevel 1 (
    echo Invalid input. Please enter a valid numeric value.
    pause
    goto use_Anatomy_Levels_of_Pure_Super_Hydrogen
)
if %use% gtr %Anatomy_Levels_of_Pure_Super_Hydrogen_balance% (
    echo Insufficient Anatomy_Levels_of_Pure_Super_Hydrogen levels.
) else (
    set /a Anatomy_Levels_of_Pure_Super_Hydrogen_balance-=%use%
    echo You have successfully used %use% Anatomy_Levels_of_Pure_Super_Hydrogen levels.
    echo Your new balance is: %Anatomy_Levels_of_Pure_Super_Hydrogen_balance% levels
)
pause
goto account_menu

:enable_reverse_aging
cls
set /p reverse_aging_eons="Enter eons to add through reverse aging: "
:: Check if reverse_aging_eons is a valid number
echo %reverse_aging_eons% | findstr /r "^[0-9]*$" >nul
if errorlevel 1 (
    echo Invalid input. Please enter a valid numeric value.
    pause
    goto enable_reverse_aging
)
set /a reverse_aging=1
echo Reverse aging enabled. You have temporarily added %reverse_aging_eons% eons.
pause
goto account_menu

:disable_reverse_aging
cls
set /a reverse_aging=0
set /a reverse_aging_eons=0
echo Reverse aging disabled.
pause
goto account_menu

:exit
cls
echo Thank you for using the 100-Eon Lifespan Management System. Goodbye!
pause
exit
