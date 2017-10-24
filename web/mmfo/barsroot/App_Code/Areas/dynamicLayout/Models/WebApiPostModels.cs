using System;

namespace Areas.dynamicLayout.Models
{
    public class CreateLayoutModel
    {
        public decimal? pMode { get; set; }
        public decimal? pDk { get; set; }
        public string pNls { get; set; }
        public string pBs { get; set; }
        public string pOb { get; set; }
        public decimal? pGrp { get; set; }
    }
    public class UpdateDynamicLayoutDataModel
    {
        public string pNd { get; set; }
        public string pDatd { get; set; }
        public string pDatFrom { get; set; }
        public string pDatTo { get; set; }
        public decimal? pDatesToNazn { get; set; }
        public string pNazn { get; set; }
        public decimal? pSum { get; set; }
        public decimal? pCorr { get; set; }

    }

    public class DeleteStaticLayoutDataModel
    {
        public decimal? pGrp { get; set; }
        public decimal? pId { get; set; }
    }

    public class AddStaticLayoutDataModel
    {
        public decimal? pId { get; set; }
        public decimal? pDk { get; set; }
        public string pNd { get; set; }
        public decimal? pKv { get; set; }
        public string pNlsa { get; set; }
        public string pNamA { get; set; }
        public string pOkpoA { get; set; }
        public string pMfoB { get; set; }
        public string pNlsB { get; set; }
        public string pNamB { get; set; }
        public string pOkpoB { get; set; }
        public decimal? pPercent { get; set; }
        public decimal? pSumA { get; set; }
        public decimal? pSumB { get; set; }
        public decimal? pDelta { get; set; }
        public string pTt { get; set; }
        public decimal? pVob { get; set; }
        public string pNazn { get; set; }
        public decimal? pOrd { get; set; }
    }

    public class SaveDetailsDataModel
    {
        public UpdateDynamicLayoutDataModel UdlModel { get; set; }
        public AddStaticLayoutDataModel AslModel { get; set; }
    }
}
