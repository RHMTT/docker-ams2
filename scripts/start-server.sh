#!/bin/bash
echo "---Checking if 'accServer.exe' is present---"
if [ ! -f ${DATA_DIR}/ams2-server-manager.exe ]; then
	touch ${DATA_DIR}/place-ams2-server-manager.exe-here
	echo "+--------------------------------------------------------"
	echo "| AMS2 Server executable not found!"
	echo "| Please be sure to place it in the root folder from the"
	echo "| Docker container!"
	echo "|"
	echo "| You have to download the AMS2"
	echo "| Dedicated Server from the Tools section in Steam."
	echo "| After the download finished right click AMS2 Server"
	echo "| -> Manage -> Browse local"
	echo "| files and copy over the 'ams2-server-manager.exe' from the"
	echo "| directory .../server/ams2-server-manager.exe to the root directory"
	echo "| from this Docker container and restart the container."
	echo "+--------------------------------------------------------"
     
	chmod -R 777 ${DATA_DIR}
	sleep infinity
else
	if [ -f ${DATA_DIR}/place-ams2-server-manager.exe-here ]; then
		rm ${DATA_DIR}/place-ams2-server-manager.exe-here
	fi
	echo "---'ams2-server-manager.exe' found, continuing...---"
fi

echo "---Prepare Server---"
echo "---Checking if config files are present---"
if [ ! -d ${DATA_DIR}/cfg ]; then
	mkdir ${DATA_DIR}/cfg
fi

export WINEARCH=win64
export WINEPREFIX=/acc/WINE64
echo "---Checking if WINE workdirectory is present---"
if [ ! -d ${DATA_DIR}/WINE64 ]; then
	echo "---WINE workdirectory not found, creating please wait...---"
	mkdir ${DATA_DIR}/WINE64
else
	echo "---WINE workdirectory found---"
fi
echo "---Checking if WINE is properly installed---"
if [ ! -d ${DATA_DIR}/WINE64/drive_c/windows ]; then
	echo "---Setting up WINE---"
	cd ${DATA_DIR}
	winecfg > /dev/null 2>&1
	sleep 15
else
	echo "---WINE properly set up---"
fi

chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
cd ${DATA_DIR}
wine64 ${DATA_DIR}/ams2-server-manager.exe
