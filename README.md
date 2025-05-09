<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Документация к PowerShell-скрипту оптимизации Windows</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            color: #333;
            margin: 0;
            padding: 0;
            line-height: 1.6;
            font-size: 18px;
        }
        header {
            background-color: #1a3d6d;
            color: white;
            padding: 10px 20px;
            text-align: center;
        }
        .header-title {
            font-size: 2rem;
            margin: 0;
        }
        .header-subtitle {
            font-size: 1rem;
            margin-top: 5px;
        }
        main {
            max-width: 1000px;
            margin: auto;
            padding: 20px;
        }
        section {
            margin-bottom: 40px;
        }
        h1, h2, h3 {
            color: #1a3d6d;
        }
        .function-block {
            background-color: #fff;
            border-left: 5px solid #1a3d6d;
            padding: 10px 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-radius: 5px;
        }
        pre {
            background-color: #2d2d2d;
            color: #f8f8f2;
            padding: 10px;
            overflow-x: auto;
            border-radius: 5px;
            font-size: 16px;
        }
        code {
            font-family: Consolas, monospace;
        }
        .note {
            background-color: #fff3cd;
            border-left: 5px solid #ffc107;
            padding: 10px;
            margin-top: 10px;
            font-style: italic;
            border-radius: 5px;
        }
        footer {
            text-align: center;
            padding: 20px;
            background-color: #eef1f5;
            font-size: 14px;
            color: #666;
        }
        a {
            color: #1a3d6d;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<main>

    <section>
        <h2>🚀 Описание</h2>
        <p>Этот PowerShell-скрипт выполняет комплексную оптимизацию Windows, включая:</p>
        <ul>
            <li>Отключение телеметрии Microsoft,</li>
            <li>Очистка временных файлов,</li>
            <li>Улучшение производительности системы,</li>
            <li>Настройку реестра,</li>
            <li>Удаление ненужных служб и задач.</li>
        </ul>
        <div class="note">
            ⚠️ <strong>ВАЖНО:</strong> Запускать только с правами администратора. Рекомендуется создать точку восстановления перед запуском.
        </div>
    </section>

    <section>
        <h2>🧩 Функционал</h2>
        <p>Скрипт выполняет следующие действия:</p>
        <ul>
            <li>Отключение служб (например, Xbox, OneDrive),</li>
            <li>Очистка логов событий,</li>
            <li>Оптимизация реестра,</li>
            <li>Управление сетевыми настройками,</li>
            <li>Повышение производительности через NUMA, DirectX, TCP/IP,</li>
            <li>Персонализация интерфейса (например, возврат старого просмотрщика изображений).</li>
        </ul>
    </section>

    <!-- Все функции -->
    <section>
        <h2>📜 Полный список функций</h2>

        <!-- Disable-Service -->
        <div class="function-block">
            <h3>Disable-Service</h3>
            <p>Отключает указанную службу и прекращает её выполнение.</p>
            <pre><code>function Disable-Service { ... }</code></pre>
        </div>

        <!-- Clear-EventLogs -->
        <div class="function-block">
            <h3>Clear-EventLogs</h3>
            <p>Очищает журналы событий Windows.</p>
            <pre><code>function Clear-EventLogs { ... }</code></pre>
        </div>

        <!-- Optimize-Registry -->
        <div class="function-block">
            <h3>Optimize-Registry</h3>
            <p>Оптимизирует параметры реестра для повышения производительности.</p>
            <pre><code>function Optimize-Registry { ... }</code></pre>
        </div>

        <!-- Apply-AdditionalRegistrySettings -->
        <div class="function-block">
            <h3>Apply-AdditionalRegistrySettings</h3>
            <p>Применяет дополнительные настройки реестра для улучшения конфиденциальности.</p>
            <pre><code>function Apply-AdditionalRegistrySettings { ... }</code></pre>
        </div>

        <!-- Optimize-Telemetry -->
        <div class="function-block">
            <h3>Optimize-Telemetry</h3>
            <p>Отключает службы сбора данных и телеметрии.</p>
            <pre><code>function Optimize-Telemetry { ... }</code></pre>
        </div>

        <!-- Clean-TempFiles -->
        <div class="function-block">
            <h3>Clean-TempFiles</h3>
            <p>Очищает временные файлы через Cleanmgr.exe.</p>
            <pre><code>function Clean-TempFiles { ... }</code></pre>
        </div>

        <!-- Configure-Security -->
        <div class="function-block">
            <h3>Configure-Security</h3>
            <p>Отключает SMBv1, NetBIOS, ICMP, RDP и другие небезопасные протоколы.</p>
            <pre><code>function Configure-Security { ... }</code></pre>
        </div>

        <!-- Configure-NetworkSettings -->
        <div class="function-block">
            <h3>Configure-NetworkSettings</h3>
            <p>Отключает IPv6, очищает ARP-кэш, настраивает DNS и LLTD.</p>
            <pre><code>function Configure-NetworkSettings { ... }</code></pre>
        </div>

        <!-- Cleanup-PowerShellTemp -->
        <div class="function-block">
            <h3>Cleanup-PowerShellTemp</h3>
            <p>Удаляет временные файлы (.tmp, .log и др.) из папок TEMP/TMP.</p>
            <pre><code>function Cleanup-PowerShellTemp { ... }</code></pre>
        </div>

        <!-- Delete-SystemRestorePoints -->
        <div class="function-block">
            <h3>Delete-SystemRestorePoints</h3>
            <p>Удаляет старые точки восстановления системы.</p>
            <pre><code>function Delete-SystemRestorePoints { ... }</code></pre>
        </div>

        <!-- Disable-UnnecessaryServices -->
        <div class="function-block">
            <h3>Disable-UnnecessaryServices</h3>
            <p>Отключает ненужные сетевые службы.</p>
            <pre><code>function Disable-UnnecessaryServices { ... }</code></pre>
        </div>

        <!-- Disable-OneDrive -->
        <div class="function-block">
            <h3>Disable-OneDrive</h3>
            <p>Останавливает и отключает службу OneDrive.</p>
            <pre><code>function Disable-OneDrive { ... }</code></pre>
        </div>

        <!-- Flush-DNSCache -->
        <div class="function-block">
            <h3>Flush-DNSCache</h3>
            <p>Очищает кэш DNS.</p>
            <pre><code>function Flush-DNSCache { ... }</code></pre>
        </div>

        <!-- Disable-BackgroundTasks -->
        <div class="function-block">
            <h3>Disable-BackgroundTasks</h3>
            <p>Отключает фоновые задачи Windows.</p>
            <pre><code>function Disable-BackgroundTasks { ... }</code></pre>
        </div>

        <!-- Disable-XboxServices -->
        <div class="function-block">
            <h3>Disable-XboxServices</h3>
            <p>Отключает службы Xbox (XblAuthManager, XblGameSave и др.).</p>
            <pre><code>function Disable-XboxServices { ... }</code></pre>
        </div>

        <!-- Cleanup-TempDirectories -->
        <div class="function-block">
            <h3>Cleanup-TempDirectories</h3>
            <p>Очищает временные каталоги (%TEMP%, %TMP% и др.).</p>
            <pre><code>function Cleanup-TempDirectories { ... }</code></pre>
        </div>

        <!-- Optimize-TCPSettings -->
        <div class="function-block">
            <h3>Optimize-TCPSettings</h3>
            <p>Оптимизирует параметры TCP/IP.</p>
            <pre><code>function Optimize-TCPSettings { ... }</code></pre>
        </div>

        <!-- Disable-Hibernation -->
        <div class="function-block">
            <h3>Disable-Hibernation</h3>
            <p>Отключает гибернацию.</p>
            <pre><code>function Disable-Hibernation { ... }</code></pre>
        </div>

        <!-- Configure-PowerSettings -->
        <div class="function-block">
            <h3>Configure-PowerSettings</h3>
            <p>Активирует схему максимальной производительности питания.</p>
            <pre><code>function Configure-PowerSettings { ... }</code></pre>
        </div>

        <!-- Cleanup-OldUpdates -->
        <div class="function-block">
            <h3>Cleanup-OldUpdates</h3>
            <p>Очищает систему от старых обновлений Windows.</p>
            <pre><code>function Cleanup-OldUpdates { ... }</code></pre>
        </div>

        <!-- Disable-ScheduledTasks -->
        <div class="function-block">
            <h3>Disable-ScheduledTasks</h3>
            <p>Отключает триггеры планировщика задач.</p>
            <pre><code>function Disable-ScheduledTasks { ... }</code></pre>
        </div>

        <!-- Enable-TRIM -->
        <div class="function-block">
            <h3>Enable-TRIM</h3>
            <p>Включает TRIM для SSD.</p>
            <pre><code>function Enable-TRIM { ... }</code></pre>
        </div>

        <!-- Optimize-NetworkIO -->
        <div class="function-block">
            <h3>Optimize-NetworkIO</h3>
            <p>Оптимизирует сетевой ввод-вывод.</p>
            <pre><code>function Optimize-NetworkIO { ... }</code></pre>
        </div>

        <!-- Optimize-DirectX -->
        <div class="function-block">
            <h3>Optimize-DirectX</h3>
            <p>Оптимизирует параметры DirectX для игр и графики.</p>
            <pre><code>function Optimize-DirectX { ... }</code></pre>
        </div>

        <!-- Optimize-NetworkAdapters -->
        <div class="function-block">
            <h3>Optimize-NetworkAdapters</h3>
            <p>Настраивает параметры сетевых адаптеров для максимальной производительности.</p>
            <pre><code>function Optimize-NetworkAdapters { ... }</code></pre>
        </div>

        <!-- Optimize-KernelMemorySettings -->
        <div class="function-block">
            <h3>Optimize-KernelMemorySettings</h3>
            <p>Оптимизирует параметры ядра и управления памятью.</p>
            <pre><code>function Optimize-KernelMemorySettings { ... }</code></pre>
        </div>

        <!-- Remove-PowerSchemes -->
        <div class="function-block">
            <h3>Remove-PowerSchemes</h3>
            <p>Удаляет стандартные схемы управления питанием.</p>
            <pre><code>function Remove-PowerSchemes { ... }</code></pre>
        </div>

        <!-- Disable-NvidiaTelemetry -->
        <div class="function-block">
            <h3>Disable-NvidiaTelemetry</h3>
            <p>Отключает телеметрию NVIDIA.</p>
            <pre><code>function Disable-NvidiaTelemetry { ... }</code></pre>
        </div>

        <!-- Apply-PrivacyAndTelemetrySettings -->
        <div class="function-block">
            <h3>Apply-PrivacyAndTelemetrySettings</h3>
            <p>Применяет настройки конфиденциальности и отключения телеметрии.</p>
            <pre><code>function Apply-PrivacyAndTelemetrySettings { ... }</code></pre>
        </div>

        <!-- Enable-WindowsPhotoViewer -->
        <div class="function-block">
            <h3>Enable-WindowsPhotoViewer</h3>
            <p>Возвращает классический просмотрщик фотографий Windows Photo Viewer.</p>
            <pre><code>function Enable-WindowsPhotoViewer { ... }</code></pre>
        </div>

        <!-- Apply-PerformanceTweaks -->
        <div class="function-block">
            <h3>Apply-PerformanceTweaks</h3>
            <p>Применяет твики производительности (рабочий стол, время ожидания и др.).</p>
            <pre><code>function Apply-PerformanceTweaks { ... }</code></pre>
        </div>

        <!-- Optimize-FileSystemSettings -->
        <div class="function-block">
            <h3>Optimize-FileSystemSettings</h3>
            <p>Настраивает параметры файловой системы через fsutil.</p>
            <pre><code>function Optimize-FileSystemSettings { ... }</code></pre>
        </div>

        <!-- Disable-ScheduledTasksFromBatch -->
        <div class="function-block">
            <h3>Disable-ScheduledTasksFromBatch</h3>
            <p>Отключает задачи планировщика из списка.</p>
            <pre><code>function Disable-ScheduledTasksFromBatch { ... }</code></pre>
        </div>

        <!-- Disable-UnnecessaryServicesFromBatch -->
        <div class="function-block">
            <h3>Disable-UnnecessaryServicesFromBatch</h3>
            <p>Отключает дополнительные службы из списка.</p>
            <pre><code>function Disable-UnnecessaryServicesFromBatch { ... }</code></pre>
        </div>

        <!-- Optimize-NUMA -->
        <div class="function-block">
            <h3>Optimize-NUMA</h3>
            <p>Оптимизирует работу NUMA для многопроцессорных систем.</p>
            <pre><code>function Optimize-NUMA { ... }</code></pre>
        </div>

        <!-- Optimize-Search -->
        <div class="function-block">
            <h3>Optimize-Search</h3>
            <p>Оптимизирует параметры поиска Windows.</p>
            <pre><code>function Optimize-Search { ... }</code></pre>
        </div>

        <!-- Check-WindowsUpdates -->
        <div class="function-block">
            <h3>Check-WindowsUpdates</h3>
            <p>Проверяет наличие доступных обновлений Windows.</p>
            <pre><code>function Check-WindowsUpdates { ... }</code></pre>
        </div>

        <!-- Configure-BatteryFlyout -->
        <div class="function-block">
            <h3>Configure-BatteryFlyout</h3>
            <p>Восстанавливает классическое окно отображения заряда батареи.</p>
            <pre><code>function Configure-BatteryFlyout { ... }</code></pre>
        </div>

        <!-- Optimize-GameMode -->
        <div class="function-block">
            <h3>Optimize-GameMode</h3>
            <p>Включает и настраивает Game Mode для игр.</p>
            <pre><code>function Optimize-GameMode { ... }</code></pre>
        </div>

        <!-- Main -->
        <div class="function-block">
            <h3>Main</h3>
            <p>Главная функция, которая запускает весь процесс оптимизации.</p>
            <pre><code>function Main { ... }</code></pre>
        </div>

    </section>

    <section>
        <h2>🏁 После завершения</h2>
        <p>После выполнения все действия записываются в файл <code>Log.log</code>. Рекомендуется перезагрузить компьютер для полного применения изменений.</p>
    </section>

    <section>
        <h2>🛠️ Как использовать</h2>
        <ol>
            <li>Запустите PowerShell от имени администратора,</li>
            <li>Перейдите в папку со скриптом,</li>
            <li>Выполните команду:
                <pre><code>.\\Optimize-Windows.ps1</code></pre>
            </li>
            <li>Подтвердите запуск словом "Да",</li>
            <li>Дождитесь окончания процесса,</li>
            <li>Можно перезагрузить систему.</li>
        </ol>
    </section>

    <section>
        <h2>📜 Лицензия</h2>
        <p>MIT License — вы можете свободно использовать, модифицировать и распространять этот скрипт при условии указания авторства.</p>
    </section>

</main>

<footer>
    &copy; 2025 Документация к скрипту оптимизации Windows | Автор: Zerio Command
</footer>

</body>
</html>
