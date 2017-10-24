=============================================================
					ОПИС ПРОЕКТУ ЦРКР BACK-END
=============================================================

ЦРКР в SVN
http://svn.unity-bars.com.ua:8080/svn/Products/ABSBars/Web/branches/COBUCRCA-9

Проект ЦРКР складається із наступних частин:

1. Безпосередньо із проекту ЦРКР
Усі файли, які стосуються веб частини ЦРКР знаходяться за наступними адресами
\barsroot\crkr_forms
\barsroot\Areas\Crkr
\barsroot\App_Code\crkr
\barsroot\App_Code\Areas\Crkr

2. Веб сервісів, які базуються на ЦРКР

\barsroot\App_Code\crkr\api\BaseProxyController --основний файл для сервісів ЦРКР та ЦАГРЦ
\barsroot\App_Code\crkr\api\CrkrMigrationsController
\barsroot\App_Code\Areas\Crkr\Infrastructure\DI\Implementation\CrkrRepository
\barsroot\App_Code\Areas\Crkr\Infrastructure\DI\Abstract\ICrkrRepository

3. Веб сервісів, які базуються на ЦА ГРЦ

\barsroot\App_Code\crkr\api\BaseProxyController --основний файл для сервісів ЦРКР та ЦАГРЦ
\barsroot\App_Code\crkr\api\CaGrcMigrationsController
\barsroot\App_Code\Areas\Crkr\Infrastructure\DI\Implementation\CaGrcRepository
\barsroot\App_Code\Areas\Crkr\Infrastructure\DI\Abstract\ICaGrcRepository

4. Веб сервіс для АБС БАРС для завантаження рахунків клієнтів при реєстрації

\barsroot\App_Code\Areas\Crkr\Controllers\ApiGetAccountController

=============================================================
Варто зазначити, що кожна з частин також включає в себе певний набір файлів із директорії Models

Також, якщо винекне потреба перезібрати оновлення для одного із вебсервісів потрібно враховувати 
клас CrkrAreaRegistration, його підключення DI може змінюватись в залежності від обраної частини.