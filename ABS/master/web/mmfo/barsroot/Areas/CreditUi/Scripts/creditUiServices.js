/**
 * Created by serhii.karchavets on 30.03.2017.
 */

angular.module("BarsWeb.Areas").factory('dataService', function(){
    return{
        afterSaveDeal: function (nd, save, isGKD) {
            return {
                nd: nd,
                prod: save.prodValue,
                fin: save.finValue.Key,
                inic: save.branchValue,
                flags: (save.holidayValue.ID) + (save.previousValue.ID),
                rang: save.rangValue.Key,
                sdi: save.discontSumValue,
                metr: save.metrValue ? save.metrValue.Key : null,
                metr_r: save.metrRateValue ? save.metrRateValue : null,
                sdate: kendo.toString(kendo.parseDate(save.conslValue), 'dd.MM.yyyy'),
                basey: save.baseyValue.Key,
                sn8: save.isPenaltiesValue ? null : save.penaltiesRateValue,
                sk4: save.earlyRateValue,
                cr9: save.unusedLimitValue,
                rnk: save.rnkValue,
                isto: save.sourValue.Key,
                kv: save.curComAccValue.Key,
                dat3: kendo.parseDate(save.issueValue),
                icr9: save.listUnsedValue.id,
                daysn: save.diffDaysValue ? save.dayPayDiffValue : null,
                datsn: save.diffDaysValue ? kendo.toString(kendo.parseDate(save.firstPayDiffValue), 'dd.MM.yyyy') : null,
                daynp: save.daynp.Key,
                vidd: save.viddValue.Key,
                inspector_id: save.inspector_id,
                s_s36: save.commissionObsl,
                //IsGKD: !isGKD ? save.belongtoGKD.id : null,
                //GKD_ND: save.gkd_id,
                BUS_MOD: save.bus_mod.Key,
                SPPI: save.sppi.Key,
                IFRS: save.ifrs,
                POCI: save.poci? save.poci.Key : null
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
        create: function (containerForSave, save, isGKD) {
            containerForSave.nRNK = save.rnkValue;
            containerForSave.CC_ID = save.numValue;
            containerForSave.Dat1 = kendo.parseDate(save.conslValue);
            containerForSave.Dat4 = kendo.parseDate(save.endValue);
            containerForSave.Dat2 = kendo.parseDate(save.startValue);
            containerForSave.Dat3 = kendo.parseDate(save.issueValue);
            containerForSave.nKV = save.curValue.Key;
            containerForSave.nS = save.sumValue;
            containerForSave.nVID = save.viddValue.Key;
            containerForSave.nISTRO = save.sourValue.Key;
            containerForSave.nCEL = !isGKD? save.aimValue.Key: null;
            containerForSave.MS_NX = save.prodValue;
            containerForSave.nFIN = save.finValue.Key;
            containerForSave.nOBS = save.obsValue.Key;
            containerForSave.sAIM = !isGKD? save.aimValue.Value: null;
            containerForSave.nKom = save.unusedLimitValue;
            containerForSave.NLS = save.nlsValue;
            containerForSave.nBANK = save.mfoValue;
            containerForSave.nFREQ = save.freqValue.Key;
            containerForSave.dfPROC = save.rateAValue;
            containerForSave.nBasey = save.baseyValue.Key;
            containerForSave.dfDen = kendo.parseInt(save.dayOfPayValue);
            containerForSave.DATNP = kendo.parseDate(save.firstPayDateValue);
            containerForSave.nFREQP = save.freqIntValue.Key;
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
                curValue: { Key: "980", Value: "" },
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
                finValue: { Key: "1", Value: "" },
                obsValue: { Key: "1", Value: "" },
                viddValue: null,
                sourValue: { Key: "4", Value: "" },
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
                baseyValue: { Key: "0", Value: "" },
                nlsValue: null,
                purposeValue: null,
                guaranteeValue: null,
                rangValue: null,
                freqValue: { Key: "5", Value: "" },
                dayOfPayValue: null,
                firstPayDateValue: null,
                holidayValue : { ID: 1 },
                freqIntValue: { Key: "5", Value: "" },
                diffDaysValue: false,
                previousValue: { ID: "0" },
                discontSumValue: null,
                curComAccValue: { Key: "980", Value: "" },
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
                lim: null,
                inspector_id: null,
                commissionObsl: null,
                belongtoGKD: { id: "", name: ""},
                gkd_id: null,
                bus_mod: { Key: "", Value: "" },
                sppi: { Key: -1, Value: "" },
                ifrs: null,
                poci: null
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
            save.curValue = { Key: resp.nKV, Value: resp.nKVNAME };
            save.sumValue = resp.nS;
            save.viddValue = { Key: resp.nVID, Value: resp.nVIDNAME };
            save.sourValue = { Key: resp.nISTRO, Value: resp.nISTRONAME };
            save.aimValue = { Key: resp.nCEL, Value: resp.AIMNAME };
            save.prodValue = resp.MS_NX;
            save.finValue = { Key: resp.nFIN, Value: resp.nFINNAME };
            save.obsValue = { Key: resp.nOBS, Value: resp.nOBSNAME };
            save.nlsValue = resp.NLS;
            save.mfoValue = resp.nBANK;
            save.branchNameValue = resp.nBANKNAME;
            save.freqValue = { Key: resp.nFREQ, Value: resp.nFREQNAME };
            save.rateAValue = resp.dfPROC;
            save.baseyValue = { Key: resp.nBasey, Value: resp.nBaseyNAME };
            save.dayOfPayValue = resp.dfDen;
            save.firstPayDateValue = resp.DATNP;
            save.freqIntValue = { Key: resp.nFREQP, Value: resp.nFREQPNAME };
            save.unusedLimitValue = resp.nKom;
            save.branchValue = resp.INIC;
            save.custValue = resp.OKPO;
            save.nmkValue = resp.NMK;
            save.prodNameValue = resp.PRODNAME;
            save.purposeValue = resp.AIMNAME;
            save.acc8 = resp.ACC8;
            save.serviceValue = { id: resp.BASEM };
            save.discontSumValue = resp.S_SDI;
            save.rangValue = { Key: resp.RANG, Value: resp.RANGNAME };
            save.metrValue = { Key: resp.METR, Value: resp.METRNAME };
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
            save.inspector_id = resp.INSPECTOR_ID;
            save.commissionObsl = resp.S_S36;
            //save.belongtoGKD = { id: resp.IsGKD };
            //save.gkd_id = resp.GKD_ND;
            save.bus_mod = { Key: resp.BUS_MOD, Value: resp.BUS_MOD_NAME };
            save.sppi = { Key: resp.SPPI };
            save.ifrs = resp.IFRS;
            save.poci = { Key: resp.POCI };
        },
        GKD: function () {
            return {
                wdate: null,
                limit: null
            }
        },
        CUST_INFO: function () {
            return {
                EDRPO: null,
                EDUCA: null,
                MEMB: null,
                NAMEW: null,
                NREMO: null,
                REMO: null,
                STAT: null,
                TYPEW: null,
                REAL6INCOME: null,
                NOREAL6INCOME: null
            }
        }
    };
});