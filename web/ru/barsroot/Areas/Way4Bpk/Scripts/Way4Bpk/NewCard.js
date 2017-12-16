/**
 * Created by serhii.karchavets on 17-Jul-17.
 */

var VALUE_LABEL_CLASS = "label label-primary";  //alert alert-success
var G_CUSTTYPE_CLAUSE = {
    1: " custtype = 3 and sed <> '91  '",        //FO
    2: "",                         //UO
    3: ""                          //SPD
};
var checkNullArr = ["W4_PRODUCT_GROUPS_REF", "GBPKW4PROECT_REF", "GBPKW4PRODUCT_REF", "GBPKW4CARD_REF"];

var g_deal = { p_gBpkW4Product: null, p_gBpkW4Card: null, p_gBpkW4ProductGrp: null,	p_gBpkW4Proect: null, p_gBpkW4Customer: null };
var g_isKievCard = false;

var IS_DEBUG = false;
function print(o) {	if(IS_DEBUG){console.log(o);}}
function isEmpty(s) { return s === undefined || s === null || s === ""; }

function getCusttype() {
    var custtype = bars.extension.getParamFromUrl('custtype');
    if(isEmpty(custtype)){
        custtype = 1;       // 1 - FO, 2 - UO, 3 - SPD
    }
    return parseInt(custtype);
}

function getUrlNewCard(isKievCard, rnk, proectId, cardCode) {
    if(getCusttype() === 2){
        return "/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.newdeal_uo&rnk=" + rnk + "&proect_id=" + proectId +
            "&card_code=" + cardCode;
    }
    if(isKievCard){
        return "/barsroot/cardkiev/cardkievparams.aspx?form=bpkw4.ref.card&rnk=" + rnk + "&proect_id=" + proectId +
            "&card_code=" + cardCode + "&card_kiev=1";
    }
    return "/barsroot/bpkw4/RegisteringNewCard?rnk=" + rnk + "&proectId=" + proectId + "&cardCode=" + cardCode + "";
}

var REFER_SETTINGS = {
    W4_PRODUCT_GROUPS_REF: {
        tabName: "v_w4_product_groups",
        whereClause: function () { return ""; },
        fields: "CODE,NAME",		                    //fields for show
        uiElem: "#gBpkW4ProductGrp",	                // ui elem - book
        uiElemValue: "#gBpkW4ProductGrpValue",	        // ui elem with value
        deal: "p_gBpkW4ProductGrp",			            // key name in g_deal
        value4save: "CODE",		                        // field name in 'tabName' for save into g_deal
        value4visible: "NAME",		                    // field name in 'tabName' for visible on UI
        gridSettings: {
            width: '600px',
            autoFitColumn: false
        }
    },
    GBPKW4PROECT_REF: {
        tabName: "v_bpk_proect",
        whereClause: function () { return "WHERE GRP_CODE = '" + g_deal[REFER_SETTINGS['W4_PRODUCT_GROUPS_REF'].deal] + "'"; },
        fields: "ID,NAME,OKPO,PRODUCT_CODE,PRODUCT_NAME,GRP_CODE",
        uiElem: "#gBpkW4Proect",
        uiElemValue: "#gBpkW4ProectValue",
        deal: "p_gBpkW4Proect",
        value4save: "ID",
        value4visible: "NAME",
        gridSettings: {
            width: '1100px',
            autoFitColumn: true
        }
    },
    GBPKW4PRODUCT_REF: {
        tabName: "V_W4_PRODUCT_UNQ",
        whereClause: function () {
            return "WHERE GRP_CODE = '" + g_deal[REFER_SETTINGS['W4_PRODUCT_GROUPS_REF'].deal] + "'" +
                " AND PROECT_ID = '" + g_deal[REFER_SETTINGS['GBPKW4PROECT_REF'].deal] + "'" +
                " and (product_code not in ('STND_UAH_VIP','STND_USD_VIP','STND_EUR_VIP')" +
                " or( product_code in ('STND_UAH_VIP','STND_USD_VIP','STND_EUR_VIP') " +
                " and sys_context('bars_context', 'user_branch')= '/322669/000120/060120/'))";
        },
        fields: "PRODUCT_CODE,PRODUCT_NAME,ACC_RATE,MOBI_RATE,CRED_RATE,OVR_RATE,LIM_RATE,GRC_RATE",
        uiElem: "#gBpkW4Product",
        uiElemValue: "#gBpkW4ProductValue",
        deal: "p_gBpkW4Product",
        value4save: "PRODUCT_CODE",
        value4visible: "PRODUCT_NAME",
        gridSettings: {
            width: '1100px',
            autoFitColumn: true
        }
    },
    GBPKW4CARD_REF: {
        tabName: "v_w4_product",
        whereClause: function () {
            return "WHERE product_code = '" + g_deal[REFER_SETTINGS['GBPKW4PRODUCT_REF'].deal] + "'" +
                " AND PROECT_ID = '" + g_deal[REFER_SETTINGS['GBPKW4PROECT_REF'].deal] + "'";
        },
        fields: "PROECT_ID,PRODUCT_CODE,CARD_CODE,SUB_NAME,KV,NBS,OB22,FLAG_KK",
        uiElem: "#gBpkW4Card",
        uiElemValue: "#gBpkW4CardValue",
        deal: "p_gBpkW4Card",
        value4save: "CARD_CODE",
        value4visible: "SUB_NAME",
        gridSettings: {
            width: '1100px',
            autoFitColumn: true
        }
    },
    GBPKW4CUSTOMER_REF: {
        tabName: getCusttype() === 1 ? "v_bpk_customer" : "v_bpk_customer_uo",
        whereClause: function () {
            var where = "WHERE";
            var newCardRnk = $("#newCardRnk").val();
            var newCardIpn = $("#newCardIpn").val();
            var newCardPib = $("#newCardPib").val();
            if(!isEmpty(newCardRnk)){ where += (" rnk = "+newCardRnk); }
            if(!isEmpty(newCardIpn)){
                if(!isEmpty(newCardRnk)){where+=" and";}
                where += (" okpo = "+newCardIpn);
            }
            if(!isEmpty(newCardPib)){
				newCardPib = replaceAll(newCardPib, "%", "");
                if(!isEmpty(newCardRnk) || !isEmpty(newCardIpn)){where+=" and";}
                where += (" upper(nmk) like '%'|| upper('" + newCardPib + "')||'%' ");
            }

            var w = G_CUSTTYPE_CLAUSE[getCusttype()];
            if(!isEmpty(w)){
                if(where !== "WHERE"){ where += " and "; }
                where += w;
            }

            if(where === "WHERE"){ where = ""; }
            return where;
        },
        fields: "RNK,OKPO,CTYPE,NMK,PK_NAME,ADR,DOC,ISSUER",
        uiElem: "#gBpkW4Customer",
        uiElemValue: "#gBpkW4CustomerValue",
        deal: "p_gBpkW4Customer",
        value4save: "RNK",
        value4visible: "NMK",
        gridSettings: {
            width: '1100px',
            autoFitColumn: true
        }
    }
};
var REFER_SETTINGS_UO_FIXED = ['W4_PRODUCT_GROUPS_REF', 'GBPKW4PROECT_REF'];

function prepareNewCard() {
    if(getCusttype() === 2){
        g_deal[REFER_SETTINGS['W4_PRODUCT_GROUPS_REF'].deal] = "CORPORATE";
        g_deal[REFER_SETTINGS['GBPKW4PROECT_REF'].deal] = -1;

        for(var j = 0; j < REFER_SETTINGS_UO_FIXED.length; j++){
            $("#fo_" + REFER_SETTINGS_UO_FIXED[j]).hide();
            $("#fo_val_" + REFER_SETTINGS_UO_FIXED[j]).hide();
        }
    }

    uiEnabled(["W4_PRODUCT_GROUPS_REF", "GBPKW4CUSTOMER_REF"], true);

    for(var i = checkNullArr.length-1; i > 0; i--){
        var isPrevVal = g_deal[REFER_SETTINGS[checkNullArr[i-1]].deal] !== null;
        uiEnabled([checkNullArr[i]], isPrevVal);
    }
}

function uiEnabled(kArr, isEnabled) {
    for(var i = 0; i < kArr.length; i++){ $(REFER_SETTINGS[kArr[i]].uiElem).prop('disabled', !isEnabled); }
}

function clearRefer(kArr) {
    for(var i = 0; i < kArr.length; i++){
        var k = kArr[i];
        g_deal[REFER_SETTINGS[k].deal] = null;
        $(REFER_SETTINGS[k].uiElemValue).removeClass(VALUE_LABEL_CLASS);
        $(REFER_SETTINGS[k].uiElemValue).text("");
    }
}

function reFillRefer(ID) {
    switch (ID){
        case "W4_PRODUCT_GROUPS_REF":
            clearRefer(["GBPKW4PROECT_REF", "GBPKW4PRODUCT_REF", "GBPKW4CARD_REF"]);
            uiEnabled(["GBPKW4PROECT_REF"], true);
            uiEnabled(["GBPKW4PRODUCT_REF", "GBPKW4CARD_REF"], false);
            break;

        case "GBPKW4PROECT_REF":
            clearRefer(["GBPKW4PRODUCT_REF", "GBPKW4CARD_REF"]);
            uiEnabled(["GBPKW4PRODUCT_REF"], true);
            uiEnabled(["GBPKW4CARD_REF"], false);
            break;

        case "GBPKW4PRODUCT_REF":
            clearRefer(["GBPKW4CARD_REF"]);
            uiEnabled(["GBPKW4CARD_REF"], true);
            break;
    }
}

function showRefer(ID) {
    if(($(REFER_SETTINGS[ID].uiElem)).prop('disabled')){
        return;
    }

    bars.ui.handBook(REFER_SETTINGS[ID].tabName, function (data) {
            var value4save = data[0][REFER_SETTINGS[ID].value4save];

            if(value4save !== g_deal[REFER_SETTINGS[ID].deal]){
                var value4visible = data[0][REFER_SETTINGS[ID].value4visible];
                var uiElVal = REFER_SETTINGS[ID].uiElemValue;
                $(uiElVal).text(value4visible);
                $(uiElVal).addClass(VALUE_LABEL_CLASS);

                g_deal[REFER_SETTINGS[ID].deal] = value4save;
                if("GBPKW4CARD_REF" === ID){
                    g_isKievCard = data[0]['FLAG_KK'] === 1;
                }

                reFillRefer(ID);

                print("g_isKievCard:"+g_isKievCard);
                print(data[0]);
                print(g_deal);

                visibilityErrorNewCard();
            }
        },
        {
            multiSelect: false,
            clause: REFER_SETTINGS[ID].whereClause(),
            columns: REFER_SETTINGS[ID].fields,
            width: REFER_SETTINGS[ID].gridSettings.width,
            autoFitColumn: REFER_SETTINGS[ID].gridSettings.autoFitColumn
        });
}

function visibilityErrorNewCard() {
    $("#selectNewCardBtn").prop('disabled', !checkNewCard());
    if(checkNewCard()){
        $("#selectNewCardErrorText").hide();
    }
    else{
        $("#selectNewCardErrorText").show();
    }
}

function checkNewCard() {
    for(var k in g_deal){ if(isEmpty(g_deal[k])){ return false; }    }
    return true;
}

function selectNewCardBtn() {
    if(!checkNewCard()){ return; }
    window.location = getUrlNewCard(g_isKievCard,
        g_deal[REFER_SETTINGS['GBPKW4CUSTOMER_REF'].deal],
        g_deal[REFER_SETTINGS['GBPKW4PROECT_REF'].deal],
        g_deal[REFER_SETTINGS['GBPKW4CARD_REF'].deal]);
}
