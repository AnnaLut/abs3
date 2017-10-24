//////////////////
/// 08/01/2014 ///
//////////////////
if (!String.prototype.trim)
{
    String.prototype.trim = function () {
        return this.replace(/^\s+|\s+$/g, '');
    }
}

//
function IsNullOrEmpty(val)
{
    if ((val == null) || (val == "") || (val.trim() == ""))
        return true;
    else
        return false;
}

// Перевірка дати вклеювання фотокартки в паспорт
function checkPhotoDate()
{
    // Якщо документ паспорт
    if (document.getElementById("listDocType").selectedIndex == 1)
    {
        // Дата народження (текст)
        var stBirth = document.getElementById("textBirthDate").value;

        // Дата видачі документу (текст)
        var stPassp = document.getElementById("textDocDate").value;

        // Дата вклеювання фотокартки (текст)
        var stPhoto = document.getElementById("textPhotoDate").value;

        if (IsNullOrEmpty(stPhoto) || IsNullOrEmpty(stBirth) || IsNullOrEmpty(stPassp))
        {
           // Якщо не в усі поля введено данні
           return;
        }
        else
        {
            // Дата поточна
            var dtCurnt = new Date();

            // Дата народження (дата)
            var dtBirth = new Date(stBirth.substr(6, 4), stBirth.substr(3, 2), stBirth.substr(0, 2));

            // Дата видачі документу (дата)
            var dtPassp = new Date(stPassp.substr(6, 4), stPassp.substr(3, 2), stPassp.substr(0, 2));

            // Дата вклеювання фотокартки (дата)
            var dtPhoto = new Date(stPhoto.substr(6, 4), stPhoto.substr(3, 2), stPhoto.substr(0, 2));

            // Вік клієнта в місяцях
            var nMonths = (dtCurnt.getFullYear() - dtBirth.getFullYear()) * 12 + (dtCurnt.getMonth() - dtBirth.getMonth());

            var nYears = 0;

            if (nMonths >= 540)
            {
                // Клієнту виповнилося 45 років (540 міс.)
                nYears = 45;
            }
            else
            {
                // Клієнту виповнилося 25 років (300 міс.)
                nYears = 25;
            }

            // Дата контрольна (25/45 річчя)
            var dtCheck = new Date(dtBirth.getFullYear() + nYears, dtBirth.getMonth(), dtBirth.getDate());

            if (dtPhoto < dtPassp)
            {
                alert("Помилка! \n Дата вклеювання фотокартки має бути більша або рівна даті видачі паспорту!");

                document.getElementById("textPhotoDate").focus();
            }
            else
            {
                if ((dtCurnt > dtCheck) && (dtPhoto < dtCheck))
                {
                    alert("Помилка! \n Дата вклеювання фотокартки має бути більша дату " + nYears + " річчя клієнта!");

                    document.getElementById("textPhotoDate").focus();
                    //document.getElementById("textPhotoDate").select();
                }
            }
        }
    }
}

// Перевірка дати видачі паспорту
function checkDocDate(elem)
{
    // Якщо документ паспорт
    if (document.getElementById("listDocType").selectedIndex == 1)
    {
        // Дата народження (текст)
        var stBirth = document.getElementById("textBirthDate").value;

        // Дата видачі документу (текст)
        var stPassp = document.getElementById("textDocDate").value;
//alert("stPassp =" +stPassp);
//alert("stBirth ="+stBirth);

        if (IsNullOrEmpty(stBirth) || IsNullOrEmpty(stPassp))
        {
            // Якщо не в усі поля введено данні
            return;  
        }
        else
        {
            // Дата народження (дата)
            var dtBirth = new Date(stBirth.substr(6, 4), stBirth.substr(3, 2), stBirth.substr(0, 2));

            // + 16 років
            dtBirth.setFullYear(dtBirth.getFullYear() + 16);

            // Дата видачі документу (дата)
            var dtPassp = new Date(stPassp.substr(6, 4), stPassp.substr(3, 2), stPassp.substr(0, 2));

            if (dtPassp < dtBirth)
            {
                alert("Помилка: \n Між датою народження та датою видачі паспорту \n менше 16 років!");

        			if (elem=="textDocDate")
				{document.getElementById(elem).focus();
                		document.getElementById(elem).select();}
				return;
            }
        }
    }
}

/// <summary>
/// Перевірка відповідності віку клієнта до "особливої відмітки"
/// </summary>
/// <param name="sMarkID">Код "особливої відмітки"</param>
/// <param name="sBirthDate">Дата народження</param>
function checkSpecialMark(source, arguments)
{
    var sMarkID = arguments.Value
    var stBirth = document.getElementById("textBirthDate").value;

    if (IsNullOrEmpty(sMarkID) || IsNullOrEmpty(stBirth))
    {
        arguments.IsValid = true;
    }
    else
    {
        // Дата народження (дата)
        var dtBirth = new Date(stBirth.substr(6, 4), stBirth.substr(3, 2) - 1, stBirth.substr(0, 2));
        
        // Поточна дата
        var dtCurnt = new Date();
        
        // Дата 14 
        var dtTemp1 = new Date(dtBirth.getFullYear() + 14, dtBirth.getMonth(), dtBirth.getDate());

        // dtTemp1.setFullYear(dtBirth.getFullYear() + 14);

        switch (sMarkID)
        {
            case '0':
            {
                if (dtCurnt > dtTemp1)
                {
                    arguments.IsValid = false;
                }
                else
                {
                    arguments.IsValid = true;
                }
                break;
            }
            case '1':
            {
                var dtTemp2 = new Date(dtBirth.getFullYear(), dtBirth.getMonth(), dtBirth.getDate());

                dtTemp2.setFullYear(dtBirth.getFullYear() + 18);

                if ((dtCurnt < dtTemp1) || (dtCurnt > dtTemp2))
                {
                    arguments.IsValid = false;
                }
                else
                {
                    arguments.IsValid = true;
                }
                break;
            }
            default:
            {
                arguments.IsValid = true;
                break;
            }
        }
    }
}

// перевірка необхідності вказзання дати вклеювання фотокартки
function checkPhotoDateRequired(source, arguments)
{
	    // Дата народження (текст)
	    var stBirth = document.getElementById("textBirthDate").value;
            // Дата видачі документу (текст)
	    var stPassp = document.getElementById("textDocDate").value;
            // Дата вклеювання фотокартки (текст)
	    var stPhoto = document.getElementById("textPhotoDate").value;
	    // Дата поточна
            var dtCurnt = new Date();
            // Дата народження (дата)
            var dtBirth = new Date(stBirth.substr(6, 4), stBirth.substr(3, 2), stBirth.substr(0, 2));
            // Дата видачі документу (дата)
            var dtPassp = new Date(stPassp.substr(6, 4), stPassp.substr(3, 2), stPassp.substr(0, 2));
            // Вік клієнта в місяцях
            var nMonths = (dtCurnt.getFullYear() - dtBirth.getFullYear()) * 12 + (dtCurnt.getMonth() - dtBirth.getMonth());
	    
            if ((nMonths == null) || (nMonths == ""))
	    {
		nMonths = 0;
	    }

	    if (nMonths >= 540)
            {
                // Клієнту виповнилося 45 років (540 міс.)
                nYears = 45;
            }
            if (nMonths >= 300)
            {
                // Клієнту виповнилося 25 років (300 міс.)
                nYears = 25;
            }
	    else 
	    {
	    	nYears = nMonths/12;   
	    }
            // Дата контрольна (25/45 річчя)
            var dtCheck = new Date(dtBirth.getFullYear() + nYears, dtBirth.getMonth(), dtBirth.getDate());
    if (
	isEmpty(arguments.Value) && 
	(document.getElementById("listDocType").selectedIndex == 1) && 
	(dtCurnt >= dtCheck) && 
	(dtPassp < dtCheck)
       )
    {
        //якщо тип документу паспорт - дата вклеювання фотокартки обов'язкова
        arguments.IsValid = false;
    }
    else
    {
        arguments.IsValid = true;
    }
}

