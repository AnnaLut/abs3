/**
 * Created by serhii.karchavets on 30.03.2017.
 */

angular.module("BarsWeb.Areas").factory('dataService', function(){
    return{
        afterSaveDeal: function (nd, save) {
            return {
                nd: nd,
                prod: save.prodValue,
                fin: save.finValue.FIN,
                inic: save.branchValue,
                flags: (save.holidayValue.ID) + (save.previousValue.ID),
                rang: save.rangValue.RANG,
                sdi: save.discontSumValue,
                metr: save.metrValue ? save.metrValue.METR : null,
                metr_r: save.metrRateValue ? save.metrRateValue : null,
                sdate: kendo.toString(kendo.parseDate(save.conslValue), 'dd.MM.yyyy'),
                basey: save.baseyValue.BASEY,
                sn8: save.isPenaltiesValue ? null : save.penaltiesRateValue,
                sk4: save.earlyRateValue,
                cr9: save.unusedLimitValue,
                rnk: save.rnkValue,
                isto: save.sourValue.SOUR,
                kv: save.curComAccValue.KV,
                dat3: kendo.parseDate(save.issueValue),
                icr9: save.listUnsedValue.id,
                daysn: save.diffDaysValue ? save.dayPayDiffValue : null,
                datsn: save.diffDaysValue ? kendo.toString(kendo.parseDate(save.firstPayDiffValue), 'dd.MM.yyyy') : null,
                daynp: save.daynp.Key
            };
        },
        multiExtInt: function (nd, save){
            return {
                ND: nd,
                BRID: save.baseRateValue,
                CBA: save.serviceValue.id == 1 ? 1 : 0,
                KV1: save.currBValue,
                PROC1: save.rateBValue,
                KV2: save.currCValue,
                PROC2: save.rateCValue,
                KV3: save.currDValue,
                PROC3: save.rateDValue,
                KV4: save.currEValue,
                PROC4: save.rateEValue
            };
        },
        create: function (containerForSave, save) {
            containerForSave.nRNK = save.rnkValue;
            containerForSave.CC_ID = save.numValue;
            containerForSave.Dat1 = kendo.parseDate(save.conslValue);
            containerForSave.Dat4 = kendo.parseDate(save.endValue);
            containerForSave.Dat2 = kendo.parseDate(save.startValue);
            containerForSave.Dat3 = kendo.parseDate(save.issueValue);
            containerForSave.nKV = save.curValue.KV;
            containerForSave.nS = save.sumValue;
            containerForSave.nVID = save.viddValue.VIDD;
            containerForSave.nISTRO = save.sourValue.SOUR;
            containerForSave.nCEL = save.aimValue.AIM;
            containerForSave.MS_NX = save.prodValue;
            containerForSave.nFIN = save.finValue.FIN;
            containerForSave.nOBS = save.obsValue.OBS;
            containerForSave.sAIM = save.aimValue.NAME;
            containerForSave.nKom = save.unusedLimitValue;
            containerForSave.NLS = save.nlsValue;
            containerForSave.nBANK = save.mfoValue;
            containerForSave.nFREQ = save.freqValue.FREQ;
            containerForSave.dfPROC = save.rateAValue;
            containerForSave.nBasey = save.baseyValue.BASEY;
            containerForSave.dfDen = kendo.parseInt(save.dayOfPayValue);
            containerForSave.DATNP = kendo.parseDate(save.firstPayDateValue);
            containerForSave.nFREQP = save.freqIntValue.FREQ;
        },
        clearMain: function () {
            return {
                ACC8: null,
                ND: null,
                nRNK: null,
                CC_ID: null,
                Dat1: null,
                Dat4: null,
                Dat2: null,
                Dat3: null,
                nKV: null,
                nS: null,
                nVID: null,
                nISTRO: null,
                nCEL: null,
                MS_NX: null,
                nFIN: null,
                nOBS: null,
                sAIM: null,
                ID: null,
                NLS: null,
                nBANK: null,
                nFREQ: null,
                dfPROC: null,
                nBasey: null,
                dfDen: null,
                DATNP: null,
                nFREQP: null,
                nKom: null
            };
        },
        clearCredit: function () {
            return {
                curValue: { KV: "980", LCV: "" },
                numValue: null,
                branchValue: null,
                sumValue: null,
                conslValue: null,
                startValue: null,
                issueValue: null,
                endValue: null,
                custValue: null,
                rnkValue: null,
                nmkValue: null,
                finValue: { FIN: "1", NAME: "" },
                obsValue: { OBS: "1", NAME: "" },
                viddValue: null,
                sourValue: { SOUR: "4", NAME: "" },
                aimValue: null,
                prodValue: null,
                prodNameValue: null,
                serviceValue: { ID: "0", NAME: "" },
                sIdValue: null,
                sCatValue: null,
                currAValue: "980",
                rateAValue: null,
                currBValue: null,
                rateBValue: null,
                currCValue: null,
                rateCValue: null,
                currDValue: null,
                rateDValue: null,
                currEValue: null,
                rateEValue: null,
                baseRateValue: null,
                baseRateNameValue: null,
                baseyValue: { BASEY: "0", NAME: "" },
                nlsValue: null,
                purposeValue: null,
                guaranteeValue: null,
                rangValue: null,
                freqValue: { FREQ: "5", NAME: "" },
                dayOfPayValue: null,
                firstPayDateValue: null,
                holidayValue : { ID: 1 },
                freqIntValue: { FREQ: "5", NAME: "" },
                diffDaysValue: false,
                previousValue: { ID: "0" },
                discontSumValue: null,
                curComAccValue: { KV: "980", LCV: "" },
                metrValue: null,
                metrRateValue: null,
                unusedLimitValue: null,
                listUnsedValue: { id: "1", name: "" },
                isPenaltiesValue: true,
                penaltiesRateValue: null,
                earlyRateValue: null,
                acc8: null,
                basem: null,
                dayPayDiffValue: null,
                firstPayDiffValue: null,
                daynp: { Key: -2 },
                lim : null
            };
        },
        getDeal: function (save, resp) {
            if(resp.FLAGS != null && resp.FLAGS != 'null' && resp.FLAGS != undefined){      // 11 10 01 00
                save.holidayValue = { ID: resp.FLAGS[0] };
                save.previousValue = { ID: resp.FLAGS[1] };
            }
            save.rnkValue = resp.nRNK;
            save.numValue = resp.CC_ID;
            save.conslValue = resp.Dat1;
            save.endValue = resp.Dat4;
            save.startValue = resp.Dat2;
            save.issueValue = resp.Dat3;
            save.curValue = { KV: resp.nKV, LCV: resp.nKVNAME };
            save.sumValue = resp.nS;
            save.viddValue = { VIDD: resp.nVID, NAME: resp.nVIDNAME };
            save.sourValue = { SOUR: resp.nISTRO, NAME: resp.nISTRONAME };
            save.aimValue = { AIM: resp.nCEL, NAME: resp.AIMNAME };
            save.prodValue = resp.MS_NX;
            save.finValue = { FIN: resp.nFIN, NAME: resp.nFINNAME };
            save.obsValue = { OBS: resp.nOBS, NAME: resp.nOBSNAME };
            save.nlsValue = resp.NLS;
            save.mfoValue = resp.nBANK;
            save.branchNameValue = resp.nBANKNAME;
            save.freqValue = { FREQ: resp.nFREQ, NAME: resp.nFREQNAME };
            save.rateAValue = resp.dfPROC;
            save.baseyValue = { BASEY: resp.nBasey, NAME: resp.nBaseyNAME };
            save.dayOfPayValue = resp.dfDen;
            save.firstPayDateValue = resp.DATNP;
            save.freqIntValue = { FREQ: resp.nFREQP, NAME: resp.nFREQPNAME };
            save.unusedLimitValue = resp.nKom;
            save.branchValue = resp.INIC;
            save.custValue = resp.OKPO;
            save.nmkValue = resp.NMK;
            save.prodNameValue = resp.PRODNAME;
            save.purposeValue = resp.AIMNAME;
            save.acc8 = resp.ACC8;
            save.serviceValue = { id: resp.BASEM };
            save.discontSumValue = resp.S_SDI;
            save.rangValue = { RANG: resp.RANG, NAME: resp.RANGNAME };
            save.metrValue = { METR: resp.METR, NAME: resp.METRNAME };
            save.metrRateValue = resp.METR_R;
            save.penaltiesRateValue = resp.SN8;
            if (save.penaltiesRateValue) save.isPenaltiesValue = false;
            save.earlyRateValue = resp.SK4;
            save.listUnsedValue = { id: resp.I_CR9, name: resp.I_CR9NAME };
            save.dayPayDiffValue = resp.DAYSN;
            save.firstPayDiffValue = resp.DATSN;
            save.daynp = { Key: resp.DAYNP };
            save.diffDaysValue = save.dayPayDiffValue ? true : false;
            save.lim = resp.LIM;
        }
    };
});