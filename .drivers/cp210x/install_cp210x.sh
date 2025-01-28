#!/bin/bash

# Устанавливаем необходимые пакеты
echo "Устанавливаем необходимые пакеты..."
sudo apt-get update
sudo apt-get install -y build-essential unzip

# Путь к репозиторию с исходниками
DRIVER_URL="https://github.com/deviashin/k_elephant/raw/main/.drivers/cp210x/Linux_3.x.x_4.x.x_VCP_Driver_Source.zip"
ZIP_FILE="Linux_3.x.x_4.x.x_VCP_Driver_Source.zip"
SOURCE_DIR="Linux_3.x.x_4.x.x_VCP_Driver_Source"

# Скачиваем архив с исходниками
echo "Скачиваем архив с исходниками..."
wget -q $DRIVER_URL -O $ZIP_FILE

# Распаковываем архив
echo "Распаковываем архив..."
unzip -q $ZIP_FILE

# Переходим в директорию с исходниками
cd $SOURCE_DIR

# Компилируем драйвер
echo "Компилируем драйвер..."
make -C /lib/modules/$(uname -r)/build M=$(pwd) modules

# Устанавливаем модуль
echo "Устанавливаем модуль..."
sudo insmod cp210x.ko

# Проверяем, что модуль установлен
dmesg | grep cp210x

echo "Драйвер успешно установлен!"
