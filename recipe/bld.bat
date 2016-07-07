setlocal EnableDelayedExpansion

:: Create the directory to hold the certificates.
if not exist %LIBRARY_PREFIX%\ssl mkdir %LIBRARY_PREFIX%\ssl
if errorlevel 1 exit 1

:: Copy the certificates from certifi.
copy /y %SP_DIR%\certifi\cacert.pem %LIBRARY_PREFIX%\ssl
if errorlevel 1 exit 1
copy /y %LIBRARY_PREFIX%\ssl\cacert.pem %LIBRARY_PREFIX%\ssl\cert.pem
if errorlevel 1 exit 1

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
FOR %%F IN (activate deactivate) DO (
    IF NOT EXIST %PREFIX%\etc\conda\%%F.d MKDIR %PREFIX%\etc\conda\%%F.d
    COPY %RECIPE_DIR%/%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
)
