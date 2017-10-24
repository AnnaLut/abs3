/**
 * Created by serhii.karchavets on 13.03.2017.
 */

// ************************************************ //
// **********       scripts before      *********** //
// ************************************************ //
//  barsroot/Scripts/jquery/jquery.iecors.js
//  barsroot/Scripts/crypto/barsCrypto.js?v1.0.0
// ************************************************ //

function createOutXml(Docs, nGrp, par, options) {
    // формируем исходящий XML
    var str_putVisaData = '<?xml version="1.0" encoding="utf-8" ?>';
    str_putVisaData += '<docs4visa grpid="' + nGrp + '" par="' + par + '">';
    for (i = 0; i < Docs.length; i++) {
        str_putVisaData += '<doc ref="' + Docs[i].ref + '" key_id="' + options.KeyId + '" sign_type="' + options.ModuleType + '" >';
        str_putVisaData += '<bufs inner_buf="' + Docs[i].int_buffer_hex + '" outer_buf="' + Docs[i].ext_buffer_hex + '" />';
        str_putVisaData += '<ecps inner_ecp="' + Docs[i].int_sign_hex + '" outer_ecp="' + Docs[i].ext_sign_hex + '" />';
        str_putVisaData += '</doc>';
    }
    str_putVisaData += '</docs4visa>';

    return str_putVisaData;
}

// Преобразование документв из XML в массив объектов
function GetDocsFromXML(xmlDoc) {
    var result = [];
    var docNodes = xmlDoc.getElementsByTagName('doc');
    for (ii = 0; ii < docNodes.length; ii++) {
        // если ошибочный то переходим к след
        if (docNodes[ii].getAttribute('err') == '1' || docNodes[ii].getAttribute('err') == '2') continue;

        // объект документа
        var doc = new oSignDoc();
        doc.ref = docNodes[ii].getAttribute('ref');
        doc.f_sign = docNodes[ii].getAttribute('f_sign');
        doc.f_check = docNodes[ii].getAttribute('f_check');

        // блок данных ЭЦП
        // внутрення ЭЦП
        var int_ecp = docNodes[ii].getElementsByTagName('int_ecp')[0];
        doc.int_buffer_hex = int_ecp.getAttribute('int_buffer_hex');

        var ecpNodesInt = int_ecp.getElementsByTagName('ecp');
        for (ii0 = 0; ii0 < ecpNodesInt.length; ii0++) {
            doc.int_ecp.push({
                id: ecpNodesInt[ii0].getAttribute('id'),
                sign_type: ecpNodesInt[ii0].getAttribute('sign_type'),
                buffer_hex: ecpNodesInt[ii0].getAttribute('buffer_hex'),
                key_id: ecpNodesInt[ii0].getAttribute('key_id'),
                sign_hex: ecpNodesInt[ii0].getAttribute('sign_hex')
            });
        }

        // внешняя ЭЦП
        var ext_ecp = docNodes[ii].getElementsByTagName('ext_ecp')[0];
        doc.ext_buffer_hex = ext_ecp.getAttribute('ext_buffer_hex');

        var ecpNodesExt = ext_ecp.getElementsByTagName('ecp')[0];
        if (ecpNodesExt) {
            doc.ext_ecp = {
                id: ecpNodesExt.getAttribute('id'),
                sign_type: ecpNodesExt.getAttribute('sign_type'),
                buffer_hex: ecpNodesExt.getAttribute('buffer_hex'),
                key_id: ecpNodesExt.getAttribute('key_id'),
                sign_hex: ecpNodesExt.getAttribute('sign_hex')
            };
        }

        result.push(doc);
    }

    return result;
}

function SignDocsRecursive(lev, Docs, grpId, par, cbSuccess, cbError) {
    // проверка дошли до дна рекурсии
    if (lev == 0) {
        cbSuccess(Docs);
        return;
    }

    barsCrypto.processDoc(Docs[lev - 1], function (result) {
        Docs[lev - 1].int_sign_hex = result.intSign;
        Docs[lev - 1].ext_sign_hex = result.extSign;
        SignDocsRecursive(lev - 1, Docs, grpId, par, cbSuccess, cbError);
    }, cbError);
}