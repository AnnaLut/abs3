CREATE INDEX BARS.I1_OTCN_SALDO ON BARS.OTCN_SALDO
(ACC, FDAT);


CREATE INDEX BARS.I2_OTCN_SALDO ON BARS.OTCN_SALDO
(RNK, ACC);


CREATE INDEX BARS.I3_OTCN_SALDO ON BARS.OTCN_SALDO
(NLS, KV);

CREATE INDEX BARS.I1_OTCN_ACC ON BARS.OTCN_ACC
(ACC);