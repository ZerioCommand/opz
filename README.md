# PowerShell-скрипт оптимизации Windows

🚀 **Этот скрипт выполняет комплексную оптимизацию Windows**, включая отключение телеметрии, улучшение производительности, настройку реестра, удаление ненужных служб и задач.

---

## 📋 Основные функции

- Отключение телеметрии Microsoft
- Очистка временных файлов и логов событий
- Улучшение производительности через настройки NUMA, DirectX, TCP/IP
- Настройка реестра и управления питанием
- Удаление ненужных служб (OneDrive, Xbox и др.)
- Восстановление старых компонентов Windows (например, классического просмотрщика изображений)

---

## ⚠️ Важно

- Рекомендуется создать **точку восстановления** перед запуском
- Все изменения записываются в файл `Log.log`
- Для полного применения изменений **необходима перезагрузка**

---

## 🔧 Как использовать

1. Откройте PowerShell **от имени администратора**
2. Перейдите в папку со скриптом:
```powershell
cd "ПУТЬ_К_ПАПКЕ"
```
3. Выполните команду:
```powershell
.\OP.ps1
```
- Либо запустите cmd который уже есть в сборке
5. Подтвердите запуск словом: `"Да"`
6. Дождитесь завершения процесса
7. Перезагрузите компьютер (по желанию)

---

## 📜 Полный список функций

| Функция | Описание |
|--------|----------|
| `Disable-Service` | Отключает указанную службу |
| `Clear-EventLogs` | Очищает журналы событий |
| `Optimize-Registry` | Оптимизация параметров реестра |
| `Apply-AdditionalRegistrySettings` | Применяет дополнительные настройки конфиденциальности |
| `Optimize-Telemetry` | Отключает телеметрию |
| `Clean-TempFiles` | Очистка временных файлов |
| `Configure-Security` | Отключение небезопасных протоколов |
| `Configure-NetworkSettings` | Настройка сетевых параметров |
| `Cleanup-PowerShellTemp` | Удаление временных файлов из TEMP/TMP |
| `Delete-SystemRestorePoints` | Удаление старых точек восстановления |
| `Disable-UnnecessaryServices` | Отключение ненужных служб |
| `Disable-OneDrive`, `Disable-XboxServices` | Отключение OneDrive и Xbox-сервисов |
| `Flush-DNSCache` | Очистка кэша DNS |
| `Disable-BackgroundTasks` | Отключение фоновых задач |
| `Cleanup-TempDirectories` | Очистка временных каталогов |
| `Optimize-TCPSettings`, `Optimize-NetworkIO`, `Optimize-NetworkAdapters` | Сетевые оптимизации |
| `Disable-Hibernation` | Отключение гибернации |
| `Configure-PowerSettings` | Активация схемы максимальной производительности |
| `Cleanup-OldUpdates` | Удаление старых обновлений |
| `Disable-ScheduledTasks` | Отключение задач планировщика |
| `Enable-TRIM` | Включение TRIM для SSD |
| `Optimize-DirectX` | Оптимизация DirectX |
| `Optimize-KernelMemorySettings` | Настройки ядра и управления памятью |
| `Remove-PowerSchemes` | Удаление стандартных схем питания |
| `Disable-NvidiaTelemetry` | Отключение телеметрии NVIDIA |
| `Apply-PrivacyAndTelemetrySettings` | Настройки конфиденциальности |
| `Enable-WindowsPhotoViewer` | Возврат старого просмотрщика изображений |
| `Apply-PerformanceTweaks` | Твики производительности |
| `Optimize-FileSystemSettings` | Настройки файловой системы |
| `Disable-ScheduledTasksFromBatch`, `Disable-UnnecessaryServicesFromBatch` | Массовое отключение задач и служб |
| `Optimize-NUMA` | Оптимизация NUMA для многопроцессорных систем |
| `Optimize-Search` | Оптимизация поиска Windows |
| `Check-WindowsUpdates` | Проверка наличия обновлений |
| `Configure-BatteryFlyout` | Классическое окно батареи |
| `Optimize-GameMode` | Настройка игрового режима |
| `Main` | Главная функция запуска |

---

## 👤 Автор

Автор: Zerio Command  
© 2025
