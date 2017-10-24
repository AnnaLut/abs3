var TranslateDict = {
	dictCode: [192, 81, 87, 69, 82, 84, 89, 85, 73, 79, 80, 219, 221, 65, 83, 68, 70, 71, 72, 74, 75, 76, 186, 222, 90, 88, 67, 86, 66, 78, 77, 188, 190, 191],
	dictChar: "'ЙЦУКЕНГШЩЗХЇФІВАПРОЛДЖЄЯЧСМИТЬБЮ."
};
var NMKCodes = {
	codes: {
		nameSource: [
			"ed_FIO_LN",    //rezident surname
			"ed_FIO_FN",	//rezident firstname
			"ed_FIO_MN"],	//rezident middlename
		nameDestination: [
			"ed_NMKV",		//destination international name
			"ed_NMKK"],		//destination short international name
		data: function () {
			return (this.nameSource + "," + this.nameDestination).split(",");
		},
		indexOf: function (token) {
			for (var item in this.nameSource) {
				if (this.nameSource[item] === token)
					return item;
			}
			return -1;
		}
	},
	containsSourceCode: function (token) {
		return (this.codes.indexOf(token) > -1);
	}
};
function translateCode(code) {
	var loc_d = TranslateDict;
	return loc_d.dictChar.charAt(jQuery.inArray(code, loc_d.dictCode));
}

function isSpd() {
	return getParamFromUrl('spd', document.URL) === '1';
}

function translateLetters(e) {
	var k = e.keyCode;

	if (jQuery.inArray(k, TranslateDict.dictCode) > -1) {
		e.stopImmediatePropagation();
		e.preventDefault();
		e.target.value += translateCode(k);
	}

	//при изменении фио, синхронизируем зависимые поля.
	if (NMKCodes.containsSourceCode(e.target.id)) {
		fieldSyncLock.events += 1;
	}
}

function isCustomer() {
	return (parent.obj_Parameters['CUSTTYPE'] == "person" && !isSpd())
}

function initTranslate(e) {
	if (isCustomer()) {
		translateLetters(e);
	}
}
var fieldSyncLock = {
	events: 0
};

setInterval(function () {
	if (fieldSyncLock.events > 0) {
		fieldSyncLock.events = 0;
		EditNMKtext();
	}
}, 1200);