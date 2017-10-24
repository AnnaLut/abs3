function ShowHideAll(imgBnt) {
    // меняем катринку
    if (imgBnt.src.endsWith('win_max_all.png'))
        imgBnt.src = imgBnt.src.replace('win_max_all.png', 'win_min_all.png');
    else
        imgBnt.src = imgBnt.src.replace('win_min_all.png', 'win_max_all.png');

    // берем все группы
    var grps = document.getElementsByTagName('input');
    for (var i = 0; i < grps.length; i++) {
        // если картинка есть заголовком групы
        var grp = grps[i];
        if (grp.type == 'image' && grp.grpid != NaN)
            ShowHide(grp);
    }
}
function ShowHide(imgBnt) {
    // група
    var grpID = imgBnt.grpid;
    var grpVisible = imgBnt.grpvisible;

    // меняем катринку
    if (grpVisible == '0') {
        imgBnt.src = imgBnt.src.replace('win_max.gif', 'win_min.gif');
        imgBnt.grpvisible = '1';
    }
    else {
        imgBnt.src = imgBnt.src.replace('win_min.gif', 'win_max.gif');
        imgBnt.grpvisible = '0';
    }

    // берем все строки из текущей группы
    var grpQuestions = document.getElementsByTagName('tr');
    for (var i = 0; i < grpQuestions.length; i++) {
        // если вопрос относиться к текущей группе
        var grpQuestion = grpQuestions[i];
        if (grpQuestion.grpid == grpID) {
            // прячм/показываем
            if (grpQuestion.grpvisible == '0') {
                Sys.UI.DomElement.removeCssClass(grpQuestion, 'rowHidden');
                grpQuestion.grpvisible = '1';
            }
            else if (grpQuestion.grpvisible == '1') {
                Sys.UI.DomElement.addCssClass(grpQuestion, 'rowHidden');
                grpQuestion.grpvisible = '0';
            }
        }
    }

    return false;
}
