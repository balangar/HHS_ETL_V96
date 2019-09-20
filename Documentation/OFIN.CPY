000100 01  CSOFINIO.                                                    CSOFINIO
000200*----------------------------------------------------------------*CSOFINIO
000300*    SUPPORT ORDER DATA BASE                                     *CSOFINIO
000400*      SEGMENT NAME: OFIN (FINANCIAL LOG)                        *CSOFINIO
000500*      KEY LENGTH = 11                                           *CSOFINIO
000600*      SEGMENT LENGTH = 64                                       *CSOFINIO
000700*----------------------------------------------------------------*CSOFINIO
000800     03  CSOFINIO-KEY.                                            CSOFINIO
000900         05  CSOFINIO-KEY-TRAN-DT          PIC 9(6).              CSOFINIO
001000         05  CSOFINIO-KEY-TRAN-TYPE        PIC 99.                CSOFINIO
001100         05  CSOFINIO-KEY-TRAN-SEQ-NO      PIC 999.               CSOFINIO
001200         05  CSOFINIO-KEY-TRAN-SEQ-NO2 REDEFINES                  CSOFINIO
001300                     CSOFINIO-KEY-TRAN-SEQ-NO.                    CSOFINIO
001400             07  CSOFINIO-KEY-TRAN-LINE-NO PIC 99.                CSOFINIO
001500             07  CSOFINIO-KEY-DUP-IND      PIC X.                 CSOFINIO
001501                                                                  CSOFINIO
001510     03  CSOFINIO-KEY2 REDEFINES CSOFINIO-KEY.                    CSOFINIO
001520         05  CSOFINIO-KEY2-COMMENT-IND     PIC X.                 CSOFINIO
001521         05  CSOFINIO-KEY2-TRAN-DT         PIC 9(6) COMP-3.       CSOFINIO
001530         05  CSOFINIO-KEY2-TRAN-TYPE       PIC X(2).              CSOFINIO
001540         05  CSOFINIO-KEY2-TRAN-SEQ-NO     PIC X(3).              CSOFINIO
001550         05  CSOFINIO-KEY2-COMMENT-SEQ     PIC 9.                 CSOFINIO
001600                                                                  CSOFINIO
001700* RECEIPT OFIN SEGMENT - TRANSACTION TYPE 01                      CSOFINIO
001800     03  CSOFINIO-T001.                                           CSOFINIO
001900         05  CSOFINIO-T001-PAY-TYPE        PIC XXX.               CSOFINIO
002000         05  CSOFINIO-T001-ALT-PAYEE       PIC X(10).             CSOFINIO
002100         05  CSOFINIO-T001-RECD-AMT        PIC S9(5)V99 COMP-3.   CSOFINIO
002200         05  CSOFINIO-T001-DEPOSIT-DT      PIC 9(6).              CSOFINIO
002300         05  FILLER                        PIC X(1).              CSOFINIO
002400         05  CSOFINIO-T001-DESC            PIC X(10).             CSOFINIO
002500         05  CSOFINIO-T001-DESC-ADJ REDEFINES                     CSOFINIO
002600               CSOFINIO-T001-DESC.                                CSOFINIO
002700             07  CSOFINIO-T001-DESC-ACT-CODE PIC XX.              CSOFINIO
002800             07  CSOFINIO-T001-DESC-ADJ-TRAN PIC XX.              CSOFINIO
002900             07  CSOFINIO-T001-DESC-ADJ-DT   PIC X(6).            CSOFINIO
003000         05  CSOFINIO-T001-SOURCE-TYPE     PIC X.                 CSOFINIO
003100         05  CSOFINIO-T001-BATCH-NO        PIC X(3).              CSOFINIO
003200         05  CSOFINIO-T001-BATCH-SEQ-NO    PIC X(3).              CSOFINIO
003300         05  CSOFINIO-T001-CLOSE-DT        PIC 9(6).              CSOFINIO
003400         05  CSOFINIO-T001-ACT-CODE        PIC XX.                CSOFINIO
003400         05  CSOFINIO-T001-RECEIPT-ON-HOLD PIC X.                 CSOFINIO
003400         05  CSOFINIO-T001-CASE-TYPE       PIC X.                 CSOFINIO
003400         05  CSOFINIO-T001-ARREARS-ONLY    PIC X.                 CSOFINIO
003500         05  FILLER                        PIC X.                 CSOFINIO
003600                                                                  CSOFINIO
003700* APPLICATION HEADER OFIN SEGMENT - TRANSACTION TYPE 02           CSOFINIO
003800     03  CSOFINIO-T002 REDEFINES CSOFINIO-T001.                   CSOFINIO
003900         05  CSOFINIO-T002-RECEIPT-DATE    PIC 9(06).             CSOFINIO
004000         05  CSOFINIO-T002-TRAN-CODE       PIC X(4).              CSOFINIO
004100         05  FILLER                        PIC X(03).             CSOFINIO
004200         05  CSOFINIO-T002-APPLIED-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
004300         05  FILLER                        PIC X(7).              CSOFINIO
004400         05  CSOFINIO-T002-DESC            PIC X(10).             CSOFINIO
004500         05  CSOFINIO-T002-DESC-ADJ REDEFINES                     CSOFINIO
004600               CSOFINIO-T002-DESC.                                CSOFINIO
004700             07  CSOFINIO-T002-DESC-ACT-CODE PIC XX.              CSOFINIO
004800             07  CSOFINIO-T002-DESC-ADJ-TRAN PIC XX.              CSOFINIO
004900             07  CSOFINIO-T002-DESC-ADJ-DT   PIC X(6).            CSOFINIO
005000         05  FILLER                        PIC X(19).             CSOFINIO
005100                                                                  CSOFINIO
005200* APPLICATION HEADER DETAIL OFIN SEGMENT - TRANSACTION TYPE 02    CSOFINIO
005300*  DUPLICATE INDICATOR 'D'                                        CSOFINIO
005400     03  CSOFINIO-T003 REDEFINES CSOFINIO-T002.                   CSOFINIO
005500         05  CSOFINIO-T003-RECD-AMT        PIC S9(5)V99 COMP-3.   CSOFINIO
005600         05  CSOFINIO-T003-PREPAY-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
005700         05  CSOFINIO-T003-FUTURE-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
005800         05  CSOFINIO-T003-GUAR-BOND-AMT   PIC S9(5)V99 COMP-3.   CSOFINIO
005800         05  CSOFINIO-T003-HOLD-AMT        PIC S9(5)V99 COMP-3.   CSOFINIO
005900         05  FILLER                        PIC X(33).             CSOFINIO
006000                                                                  CSOFINIO
006100* APPLICATION DETAIL OFIN SEGMENT - TRANSACTION TYPE 02           CSOFINIO
006200     03  CSOFINIO-T004 REDEFINES CSOFINIO-T003.                   CSOFINIO
006300         05  CSOFINIO-T004-PAY-TYPE        PIC XXX.               CSOFINIO
006400         05  CSOFINIO-T004-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
006500         05  CSOFINIO-T004-APPLIED-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
006600         05  CSOFINIO-T004-SUP-ORD-NO      PIC X(17).             CSOFINIO
006700         05  CSOFINIO-T004-SUP-ORD-NO-DESC                        CSOFINIO
006800                       REDEFINES CSOFINIO-T004-SUP-ORD-NO.        CSOFINIO
006900             07 FILLER                     PIC X(7).              CSOFINIO
007000             07 CSOFINIO-T004-DESC         PIC X(10).             CSOFINIO
007100             07 CSOFINIO-T004-DESC-ADJ REDEFINES                  CSOFINIO
007200                   CSOFINIO-T004-DESC.                            CSOFINIO
007300                 09 CSOFINIO-T004-DESC-ACT-CODE PIC XX.           CSOFINIO
007400                 09 CSOFINIO-T004-DESC-ADJ-TRAN PIC XX.           CSOFINIO
007500                 09 CSOFINIO-T004-DESC-ADJ-DT   PIC X(6).         CSOFINIO
007600             07 CSOFINIO-T004-HOLD REDEFINES                      CSOFINIO
007700                   CSOFINIO-T004-DESC.                            CSOFINIO
007800                 09  CSOFINIO-T004-HOLD-CODE   PIC X(3).          CSOFINIO
007900                 09  FILLER                    PIC X.             CSOFINIO
008000                 09  CSOFINIO-T004-HOLD-DATE   PIC 9(6).          CSOFINIO
008100         05  CSOFINIO-T004-ARREAR-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
008200         05  CSOFINIO-T004-END-DT          PIC 9(6).              CSOFINIO
008300         05  CSOFINIO-T004-CHECK-STATUS    PIC XX.                CSOFINIO
008400         05  CSOFINIO-T004-CHECK-STATUS-DT PIC 9(6).              CSOFINIO
008500         05  CSOFINIO-T004-APPL-HOLD-IND   PIC X.                 CSOFINIO
008600                                                                  CSOFINIO
008700* DISBURSEMENT HEADER OFIN SEGMENT - TRANSACTION TYPE 03          CSOFINIO
008800     03  CSOFINIO-T005 REDEFINES CSOFINIO-T004.                   CSOFINIO
008900         05  FILLER                        PIC X(13).             CSOFINIO
009000         05  CSOFINIO-T005-DISBURSD-AMT    PIC S9(5)V99 COMP-3.   CSOFINIO
009100         05  FILLER                        PIC X(7).              CSOFINIO
009200         05  CSOFINIO-T005-DESC            PIC X(10).             CSOFINIO
009300         05  CSOFINIO-T005-DESC-ADJ REDEFINES                     CSOFINIO
009400               CSOFINIO-T005-DESC.                                CSOFINIO
009500             07  CSOFINIO-T005-DESC-ACT-CODE PIC XX.              CSOFINIO
009600             07  CSOFINIO-T005-DESC-ADJ-TRAN PIC XX.              CSOFINIO
009700             07  CSOFINIO-T005-DESC-ADJ-DT   PIC X(6).            CSOFINIO
009800         05  CSOFINIO-T005-CHECK-NUMBER    PIC X(7).
009900         05  FILLER                        PIC X(12).             CSOFINIO
010000                                                                  CSOFINIO
010100* DISBURSEMENT DETAIL OFIN SEGMENT - TRANSACTION TYPE 03          CSOFINIO
010200     03  CSOFINIO-T006 REDEFINES CSOFINIO-T005.                   CSOFINIO
010300         05  CSOFINIO-T006-PAY-TYPE        PIC X(3).              CSOFINIO
010400         05  CSOFINIO-T006-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
010500         05  CSOFINIO-T006-CHECK-AMT       PIC S9(5)V99 COMP-3.   CSOFINIO
010600         05  CSOFINIO-T006-CHECK-NO        PIC X(7).              CSOFINIO
010700         05  CSOFINIO-T006-DESC            PIC X(10).             CSOFINIO
010800         05  CSOFINIO-T006-DESC-ADJ REDEFINES                     CSOFINIO
010900               CSOFINIO-T006-DESC.                                CSOFINIO
011000             07  CSOFINIO-T006-DESC-ACT-CODE PIC XX.              CSOFINIO
011100             07  CSOFINIO-T006-DESC-ADJ-TRAN PIC XX.              CSOFINIO
011200             07  CSOFINIO-T006-DESC-ADJ-DT   PIC X(6).            CSOFINIO
011300         05  CSOFINIO-T006-APPLICATION-DT  PIC 9(06).             CSOFINIO
011400         05  FILLER                        PIC X(13).             CSOFINIO
011500                                                                  CSOFINIO
011600* ADJUSTMENT HEADER OFIN SEGMENT - TRANSACTION TYPE 04            CSOFINIO
011700     03  CSOFINIO-T007 REDEFINES CSOFINIO-T006.                   CSOFINIO
011800         05  CSOFINIO-T007-PAY-TYPE        PIC X(3).
011900         05  FILLER                        PIC X(10).             CSOFINIO
012000         05  CSOFINIO-T007-ADJ-AMT         PIC S9(5)V99 COMP-3.   CSOFINIO
012100         05  CSOFINIO-T007-DEPOSIT-DATE    PIC 9(6).              CSOFINIO
012200         05  FILLER                        PIC X.
012300         05  CSOFINIO-T007-DESC            PIC X(10).             CSOFINIO
012400         05  CSOFINIO-T007-DESC-ADJ REDEFINES                     CSOFINIO
012500               CSOFINIO-T007-DESC.                                CSOFINIO
012600             07  CSOFINIO-T007-DESC-ACT-CODE PIC XX.              CSOFINIO
012700             07  CSOFINIO-T007-DESC-ADJ-TRAN PIC XX.              CSOFINIO
012800             07  CSOFINIO-T007-DESC-ADJ-DT   PIC X(6).            CSOFINIO
012900         05  CSOFINIO-T007-PAYMENT-SOURCE  PIC X.
013000         05  CSOFINIO-T007-BATCH-NO        PIC X(3).
013100         05  CSOFINIO-T007-SEQ-NO          PIC X(3).
013200         05  FILLER                        PIC X(12).             CSOFINIO
013300                                                                  CSOFINIO
013400* DISTRIBUTION HEADER OFIN SEGMENT - TRANSACTION TYPE 05          CSOFINIO
013500     03  CSOFINIO-T009 REDEFINES CSOFINIO-T007.                   CSOFINIO
013600         05  FILLER                        PIC X(13).             CSOFINIO
013700         05  CSOFINIO-T009-DISTR-AMT       PIC S9(5)V99 COMP-3.   CSOFINIO
013800         05  FILLER                        PIC X(7).              CSOFINIO
013900         05  CSOFINIO-T009-DESC            PIC X(10).             CSOFINIO
014000         05  CSOFINIO-T009-DESC-ADJ REDEFINES                     CSOFINIO
014100               CSOFINIO-T009-DESC.                                CSOFINIO
014200             07  CSOFINIO-T009-DESC-ACT-CODE PIC XX.              CSOFINIO
014300             07  CSOFINIO-T009-DESC-ADJ-TRAN PIC XX.              CSOFINIO
014400             07  CSOFINIO-T009-DESC-ADJ-DT   PIC X(6).            CSOFINIO
014500         05  FILLER                        PIC X(19).             CSOFINIO
014600                                                                  CSOFINIO
014700* DISTRIBUTION DETAIL OFIN SEGMENT - TRANSACTION TYPE 05          CSOFINIO
014800     03  CSOFINIO-T010 REDEFINES CSOFINIO-T009.                   CSOFINIO
014900         05  CSOFINIO-T010-PAY-TYPE        PIC X(3).              CSOFINIO
015000         05  CSOFINIO-T010-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
015100         05  CSOFINIO-T010-CHECK-AMT       PIC S9(5)V99 COMP-3.   CSOFINIO
015200         05  CSOFINIO-T010-CHECK-NO        PIC X(7).              CSOFINIO
015300         05  CSOFINIO-T010-DESC            PIC X(10).             CSOFINIO
015400         05  CSOFINIO-T010-DESC-ADJ REDEFINES                     CSOFINIO
015500               CSOFINIO-T010-DESC.                                CSOFINIO
015600             07  CSOFINIO-T010-DESC-ACT-CODE PIC XX.              CSOFINIO
015700             07  CSOFINIO-T010-DESC-ADJ-TRAN PIC XX.              CSOFINIO
015800             07  CSOFINIO-T010-DESC-ADJ-DT   PIC X(6).            CSOFINIO
015900         05  CSOFINIO-T010-APPLICATION-DT    PIC 9(6).            CSOFINIO
016000         05  CSOFINIO-T010-END-DT            PIC 9(6).            CSOFINIO
016100         05  FILLER                        PIC X(7).              CSOFINIO
016200                                                                  CSOFINIO
016300* REPLACEMENT OFIN SEGMENT - TRANSACTION TYPE 06                  CSOFINIO
016400     03  CSOFINIO-T011 REDEFINES CSOFINIO-T010.                   CSOFINIO
016500         05  CSOFINIO-T011-PAY-TYPE        PIC X(3).
016600         05  FILLER                        PIC X(10).             CSOFINIO
016700         05  CSOFINIO-T011-ADJ-AMT         PIC S9(5)V99 COMP-3.   CSOFINIO
016800         05  CSOFINIO-T011-DEPOSIT-DATE    PIC 9(6).              CSOFINIO
016900         05  FILLER                        PIC X.
017000         05  CSOFINIO-T011-DESC            PIC X(10).             CSOFINIO
017100         05  CSOFINIO-T011-DESC-ADJ REDEFINES                     CSOFINIO
017200               CSOFINIO-T011-DESC.                                CSOFINIO
017300             07  CSOFINIO-T011-DESC-ACT-CODE PIC XX.              CSOFINIO
017400             07  CSOFINIO-T011-DESC-ADJ-TRAN PIC XX.              CSOFINIO
017500             07  CSOFINIO-T011-DESC-ADJ-DT   PIC X(6).            CSOFINIO
017600         05  CSOFINIO-T011-PAYMENT-SOURCE  PIC X.
017700         05  CSOFINIO-T011-BATCH-NO        PIC X(3).
017800         05  CSOFINIO-T011-SEQ-NO          PIC X(3).
017900         05  FILLER                        PIC X(12).             CSOFINIO
018000                                                                  CSOFINIO
018100* REDUCE ARREARAGE HEADER OFIN SEGMENT - TRANSACTION TYPE 07      CSOFINIO
018200     03  CSOFINIO-T012 REDEFINES CSOFINIO-T011.                   CSOFINIO
018300         05  FILLER                        PIC X(13).             CSOFINIO
018400         05  CSOFINIO-T012-TOT-REDUCE-AMT  PIC S9(5)V99 COMP-3.   CSOFINIO
018500         05  FILLER                        PIC X(36).             CSOFINIO
018600                                                                  CSOFINIO
018700* REDUCE ARREARAGE DETAIL OFIN SEGMENT - TRANSACTION TYPE 07      CSOFINIO
018800     03  CSOFINIO-T013 REDEFINES CSOFINIO-T012.                   CSOFINIO
018900         05  CSOFINIO-T013-PAY-TYPE        PIC X(3).              CSOFINIO
019000         05  CSOFINIO-T013-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
019100         05  CSOFINIO-T013-DELQ-AMT        PIC S9(5)V99 COMP-3.   CSOFINIO
019200         05  CSOFINIO-T013-CLOSE-DT        PIC 9(6).              CSOFINIO
019300         05  CSOFINIO-T013-DELQ-DT         PIC 9(6).              CSOFINIO
019400         05  CSOFINIO-T013-FREQ            PIC X.                 CSOFINIO
019500         05  FILLER                        PIC X(23).             CSOFINIO
019600                                                                  CSOFINIO
019700* RELEASE HOLD DETAIL OFIN SEGMENT - TRANSACTION TYPE 08          CSOFINIO
019800     03  CSOFINIO-T014 REDEFINES CSOFINIO-T012.                   CSOFINIO
019900         05  CSOFINIO-T014-PAY-TYPE        PIC X(3).              CSOFINIO
020000         05  CSOFINIO-T014-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
020100         05  CSOFINIO-T014-RELEASED-AMT    PIC S9(5)V99 COMP-3.   CSOFINIO
020200         05  CSOFINIO-T014-REASON-CODE     PIC XXX.               CSOFINIO
020300         05  CSOFINIO-T014-HOLD-DT         PIC 9(6).              CSOFINIO
020400         05  FILLER                        PIC X(27).             CSOFINIO
020500                                                                  CSOFINIO
020600* OVERPAYMENT HEADER OFIN SEGMENT - TRANSACTION TYPE 09           CSOFINIO
020700     03  CSOFINIO-T015 REDEFINES CSOFINIO-T014.                   CSOFINIO
020800         05  FILLER                        PIC X(13).             CSOFINIO
020900         05  CSOFINIO-T015-OVERPAY-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
021000         05  FILLER                        PIC X(36).             CSOFINIO
021100                                                                  CSOFINIO
021200* OVERPAYMENT HEADER DETAIL OFIN SEGMENT - TRANSACTION TYPE 09    CSOFINIO
021300*  DUPLICATE INDICATOR 'D'                                        CSOFINIO
021400     03  CSOFINIO-T016 REDEFINES CSOFINIO-T015.                   CSOFINIO
021500         05  CSOFINIO-T016-PREPAY-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
021600         05  CSOFINIO-T016-FUTURE-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
021700         05  CSOFINIO-T016-GUAR-BOND-AMT   PIC S9(5)V99 COMP-3.   CSOFINIO
021800         05  CSOFINIO-T016-PAY-TYPE        PIC XXX.               CSOFINIO
021900         05  CSOFINIO-T016-SUP-ORD-NO      PIC X(16).             CSOFINIO
022000         05  CSOFINIO-T016-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
022100         05  CSOFINIO-T016-CLOSE-DT        PIC 9(6).              CSOFINIO
022200         05  FILLER                        PIC X(06).             CSOFINIO
022300                                                                  CSOFINIO
022400* CREATE ARREARAGE OFIN SEGMENT - TRANSACTION TYPE 10             CSOFINIO
022500     03  CSOFINIO-T017 REDEFINES CSOFINIO-T016.                   CSOFINIO
022600         05  CSOFINIO-T017-PAY-TYPE        PIC X(3).              CSOFINIO
022700         05  CSOFINIO-T017-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
022800         05  CSOFINIO-T017-CREATE-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
022900         05  CSOFINIO-T017-CLOSE-DT        PIC 9(6).              CSOFINIO
023000         05  CSOFINIO-T017-DELQ-DT         PIC 9(6).              CSOFINIO
023100         05  CSOFINIO-T017-FREQ            PIC X.                 CSOFINIO
023200         05  FILLER                        PIC X(23).             CSOFINIO
023300                                                                  CSOFINIO
023400* STOP PAY ADJUSTMENT HEADER OFIN SEGMENT - TRANSACTION TYPE 11   CSOFINIO
023500     03  CSOFINIO-T018 REDEFINES CSOFINIO-T017.                   CSOFINIO
023600         05  FILLER                        PIC X(13).             CSOFINIO
023700         05  CSOFINIO-T018-TOT-CHECK-AMT   PIC S9(5)V99 COMP-3.   CSOFINIO
023800         05  FILLER                        PIC X(7).              CSOFINIO
023900         05  CSOFINIO-T018-DESC            PIC X(10).             CSOFINIO
024000         05  CSOFINIO-T018-DESC-ADJ REDEFINES                     CSOFINIO
024100               CSOFINIO-T018-DESC.                                CSOFINIO
024200             07  CSOFINIO-T018-DESC-ACT-CODE PIC XX.              CSOFINIO
024300             07  CSOFINIO-T018-DESC-ADJ-TRAN PIC XX.              CSOFINIO
024400             07  CSOFINIO-T018-DESC-ADJ-DT   PIC X(6).            CSOFINIO
024500         05  FILLER                        PIC X(19).             CSOFINIO
024600                                                                  CSOFINIO
024700* STOP PAY ADJUSTMENT DETAIL OFIN SEGMENT - TRANSACTION TYPE 11   CSOFINIO
024800     03  CSOFINIO-T019 REDEFINES CSOFINIO-T018.                   CSOFINIO
024900         05  CSOFINIO-T019-PAY-TYPE        PIC X(3).              CSOFINIO
025000         05  CSOFINIO-T019-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
025100         05  CSOFINIO-T019-CHECK-AMT       PIC S9(5)V99 COMP-3.   CSOFINIO
025200         05  CSOFINIO-T019-CHECK-NO        PIC X(7).              CSOFINIO
025300         05  CSOFINIO-T019-DESC            PIC X(10).             CSOFINIO
025400         05  CSOFINIO-T019-DESC-ADJ REDEFINES                     CSOFINIO
025500               CSOFINIO-T019-DESC.                                CSOFINIO
025600             07  CSOFINIO-T019-DESC-ACT-CODE PIC XX.              CSOFINIO
025700             07  CSOFINIO-T019-DESC-ADJ-TRAN PIC XX.              CSOFINIO
025800             07  CSOFINIO-T019-DESC-ADJ-DT   PIC X(6).            CSOFINIO
025900         05  FILLER                        PIC X(19).             CSOFINIO
026000                                                                  CSOFINIO
026100* RELEASE STOP PAY ADJUSTMENT HEADER OFIN SEGMENT                 CSOFINIO
026200* TRANSACTION TYPE 12                                             CSOFINIO
026300     03  CSOFINIO-T020 REDEFINES CSOFINIO-T019.                   CSOFINIO
026400         05  FILLER                        PIC X(13).             CSOFINIO
026500         05  CSOFINIO-T020-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
026600         05  FILLER                        PIC X(7).              CSOFINIO
026700         05  CSOFINIO-T020-DESC            PIC X(10).             CSOFINIO
026800         05  CSOFINIO-T020-DESC-ADJ REDEFINES                     CSOFINIO
026900               CSOFINIO-T020-DESC.                                CSOFINIO
027000             07  CSOFINIO-T020-DESC-ACT-CODE PIC XX.              CSOFINIO
027100             07  CSOFINIO-T020-DESC-ADJ-TRAN PIC XX.              CSOFINIO
027200             07  CSOFINIO-T020-DESC-ADJ-DT   PIC X(6).            CSOFINIO
027300         05  FILLER                        PIC X(19).             CSOFINIO
027400                                                                  CSOFINIO
027500* RELEASE STOP PAY ADJUSTMENT DETAIL OFIN SEGMENT                 CSOFINIO
027600* TRANSACTION TYPE 12                                             CSOFINIO
027700     03  CSOFINIO-T021 REDEFINES CSOFINIO-T020.                   CSOFINIO
027800         05  CSOFINIO-T021-PAY-TYPE        PIC X(3).              CSOFINIO
027900         05  CSOFINIO-T021-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
028000         05  CSOFINIO-T021-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
028100         05  CSOFINIO-T021-CHECK-NO        PIC X(7).              CSOFINIO
028200         05  CSOFINIO-T021-DESC            PIC X(10).             CSOFINIO
028300         05  CSOFINIO-T021-DESC-ADJ REDEFINES                     CSOFINIO
028400               CSOFINIO-T021-DESC.                                CSOFINIO
028500             07  CSOFINIO-T021-DESC-ACT-CODE PIC XX.              CSOFINIO
028600             07  CSOFINIO-T021-DESC-ADJ-TRAN PIC XX.              CSOFINIO
028700             07  CSOFINIO-T021-DESC-ADJ-DT   PIC X(6).            CSOFINIO
028800         05  FILLER                        PIC X(19).             CSOFINIO
028900                                                                  CSOFINIO
029000* CANCEL ADJUSTMENT HEADER OFIN - TRANSACTION TYPE 13             CSOFINIO
029100     03  CSOFINIO-T022 REDEFINES CSOFINIO-T021.                   CSOFINIO
029200         05  FILLER                        PIC X(13).             CSOFINIO
029300         05  CSOFINIO-T022-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
029400         05  FILLER                        PIC X(7).              CSOFINIO
029500         05  CSOFINIO-T022-DESC            PIC X(10).             CSOFINIO
029600         05  CSOFINIO-T022-DESC-ADJ REDEFINES                     CSOFINIO
029700               CSOFINIO-T022-DESC.                                CSOFINIO
029800             07  CSOFINIO-T022-DESC-ACT-CODE PIC XX.              CSOFINIO
029900             07  CSOFINIO-T022-DESC-ADJ-TRAN PIC XX.              CSOFINIO
030000             07  CSOFINIO-T022-DESC-ADJ-DT   PIC X(6).            CSOFINIO
030100         05  FILLER                        PIC X(19).             CSOFINIO
030200                                                                  CSOFINIO
030300* CANCEL ADJUSTMENT DETAIL OFIN - TRANSACTION TYPE 13             CSOFINIO
030400     03  CSOFINIO-T023 REDEFINES CSOFINIO-T022.                   CSOFINIO
030500         05  CSOFINIO-T023-PAY-TYPE        PIC X(3).              CSOFINIO
030600         05  CSOFINIO-T023-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
030700         05  CSOFINIO-T023-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
030800         05  CSOFINIO-T023-CHECK-NO        PIC X(7).              CSOFINIO
030900         05  CSOFINIO-T023-DESC            PIC X(10).             CSOFINIO
031000         05  CSOFINIO-T023-DESC-ADJ REDEFINES                     CSOFINIO
031100               CSOFINIO-T023-DESC.                                CSOFINIO
031200             07  CSOFINIO-T023-DESC-ACT-CODE PIC XX.              CSOFINIO
031300             07  CSOFINIO-T023-DESC-ADJ-TRAN PIC XX.              CSOFINIO
031400             07  CSOFINIO-T023-DESC-ADJ-DT   PIC X(6).            CSOFINIO
031500         05  FILLER                        PIC X(19).             CSOFINIO
031600                                                                  CSOFINIO
031700* RELEASE CANCEL ADJUSTMENT HEADER OFIN - TRANSACTION TYPE 14     CSOFINIO
031800     03  CSOFINIO-T024 REDEFINES CSOFINIO-T023.                   CSOFINIO
031900         05  FILLER                        PIC X(13).             CSOFINIO
032000         05  CSOFINIO-T024-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
032100         05  FILLER                        PIC X(7).              CSOFINIO
032200         05  CSOFINIO-T024-DESC            PIC X(10).             CSOFINIO
032300         05  CSOFINIO-T024-DESC-ADJ REDEFINES                     CSOFINIO
032400               CSOFINIO-T024-DESC.                                CSOFINIO
032500             07  CSOFINIO-T024-DESC-ACT-CODE PIC XX.              CSOFINIO
032600             07  CSOFINIO-T024-DESC-ADJ-TRAN PIC XX.              CSOFINIO
032700             07  CSOFINIO-T024-DESC-ADJ-DT   PIC X(6).            CSOFINIO
032800         05  FILLER                        PIC X(19).             CSOFINIO
032900                                                                  CSOFINIO
033000* RELEASE CANCEL ADJUSTMENT DETAIL OFIN - TRANSACTION TYPE 14     CSOFINIO
033100     03  CSOFINIO-T025 REDEFINES CSOFINIO-T024.                   CSOFINIO
033200         05  CSOFINIO-T025-PAY-TYPE        PIC X(3).              CSOFINIO
033300         05  CSOFINIO-T025-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
033400         05  CSOFINIO-T025-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
033500         05  CSOFINIO-T025-CHECK-NO        PIC X(7).              CSOFINIO
033600         05  CSOFINIO-T025-DESC            PIC X(10).             CSOFINIO
033700         05  CSOFINIO-T025-DESC-ADJ REDEFINES                     CSOFINIO
033800               CSOFINIO-T025-DESC.                                CSOFINIO
033900             07  CSOFINIO-T025-DESC-ACT-CODE PIC XX.              CSOFINIO
034000             07  CSOFINIO-T025-DESC-ADJ-TRAN PIC XX.              CSOFINIO
034100             07  CSOFINIO-T025-DESC-ADJ-DT   PIC X(6).            CSOFINIO
034200         05  FILLER                        PIC X(19).             CSOFINIO
034300* REISSUE ADJUSTMENT HEADER OFIN - TRANSACTION TYPE 15            CSOFINIO
034400     03  CSOFINIO-T026 REDEFINES CSOFINIO-T025.                   CSOFINIO
034500         05  FILLER                        PIC X(13).             CSOFINIO
034600         05  CSOFINIO-T026-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
034700         05  FILLER                        PIC X(7).              CSOFINIO
034800         05  CSOFINIO-T026-DESC            PIC X(10).             CSOFINIO
034900         05  CSOFINIO-T026-DESC-ADJ REDEFINES                     CSOFINIO
035000               CSOFINIO-T026-DESC.                                CSOFINIO
035100             07  CSOFINIO-T026-DESC-ACT-CODE PIC XX.              CSOFINIO
035200             07  CSOFINIO-T026-DESC-ADJ-TRAN PIC XX.              CSOFINIO
035300             07  CSOFINIO-T026-DESC-ADJ-DT   PIC X(6).            CSOFINIO
035400         05  FILLER                        PIC X(19).             CSOFINIO
035500                                                                  CSOFINIO
035600* REISSUE ADJUSTMENT DETAIL OFIN - TRANSACTION TYPE 15            CSOFINIO
035700     03  CSOFINIO-T027 REDEFINES CSOFINIO-T026.                   CSOFINIO
035800         05  CSOFINIO-T027-PAY-TYPE        PIC X(3).              CSOFINIO
035900         05  CSOFINIO-T027-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
036000         05  CSOFINIO-T027-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
036100         05  CSOFINIO-T027-CHECK-NO        PIC X(7).              CSOFINIO
036200         05  CSOFINIO-T027-DESC            PIC X(10).             CSOFINIO
036300         05  CSOFINIO-T027-DESC-ADJ REDEFINES                     CSOFINIO
036400               CSOFINIO-T027-DESC.                                CSOFINIO
036500             07  CSOFINIO-T027-DESC-ACT-CODE PIC XX.              CSOFINIO
036600             07  CSOFINIO-T027-DESC-ADJ-TRAN PIC XX.              CSOFINIO
036700             07  CSOFINIO-T027-DESC-ADJ-DT   PIC X(6).            CSOFINIO
036800         05  FILLER                        PIC X(19).             CSOFINIO
036900                                                                  CSOFINIO
037000* BACKOUT ADJUSTMENT HEADER OFIN - TRANSACTION TYPE 16            CSOFINIO
037100     03  CSOFINIO-T028 REDEFINES CSOFINIO-T027.                   CSOFINIO
037200         05  FILLER                        PIC X(13).             CSOFINIO
037300         05  CSOFINIO-T028-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
037400         05  FILLER                        PIC X(7).              CSOFINIO
037500         05  CSOFINIO-T028-DESC            PIC X(10).             CSOFINIO
037600         05  CSOFINIO-T028-DESC-ADJ REDEFINES                     CSOFINIO
037700               CSOFINIO-T028-DESC.                                CSOFINIO
037800             07  CSOFINIO-T028-DESC-ACT-CODE PIC XX.              CSOFINIO
037900             07  CSOFINIO-T028-DESC-ADJ-TRAN PIC XX.              CSOFINIO
038000             07  CSOFINIO-T028-DESC-ADJ-DT   PIC X(6).            CSOFINIO
038100         05  FILLER                        PIC X(19).             CSOFINIO
038200                                                                  CSOFINIO
038300* BACKOUT ADJUSTMENT DETAIL OFIN - TRANSACTION TYPE 16            CSOFINIO
038400     03  CSOFINIO-T029 REDEFINES CSOFINIO-T028.                   CSOFINIO
038500         05  CSOFINIO-T029-PAY-TYPE        PIC X(3).              CSOFINIO
038600         05  CSOFINIO-T029-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
038700         05  CSOFINIO-T029-TOT-ADJ-AMT     PIC S9(5)V99 COMP-3.   CSOFINIO
038800         05  CSOFINIO-T029-CHECK-NO        PIC X(7).              CSOFINIO
038900         05  CSOFINIO-T029-DESC            PIC X(10).             CSOFINIO
039000         05  CSOFINIO-T029-DESC-ADJ REDEFINES                     CSOFINIO
039100               CSOFINIO-T029-DESC.                                CSOFINIO
039200             07  CSOFINIO-T029-DESC-ACT-CODE PIC XX.              CSOFINIO
039300             07  CSOFINIO-T029-DESC-ADJ-TRAN PIC XX.              CSOFINIO
039400             07  CSOFINIO-T029-DESC-ADJ-DT   PIC X(6).            CSOFINIO
039500         05  CSOFINIO-T029-ARREAR-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
039600         05  CSOFINIO-T029-END-DT          PIC 9(6).              CSOFINIO
039700         05  FILLER                        PIC X(09).             CSOFINIO
039800                                                                  CSOFINIO
039900* FUTURE ARRS PAYMENT DETAIL OFIN SEGMENT - TRANSACTION TYPE 17   CSOFINIO
040100     03  CSOFINIO-T030 REDEFINES CSOFINIO-T029.                   CSOFINIO
040200         05  CSOFINIO-T030-PREPAY-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
040300         05  CSOFINIO-T030-FUTURE-AMT      PIC S9(5)V99 COMP-3.   CSOFINIO
040400         05  CSOFINIO-T030-GUAR-BOND-AMT   PIC S9(5)V99 COMP-3.   CSOFINIO
040500         05  CSOFINIO-T030-PAY-TYPE        PIC XXX.               CSOFINIO
040600         05  CSOFINIO-T030-SUP-ORD-NO      PIC X(16).             CSOFINIO
040700         05  CSOFINIO-T030-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
040800         05  CSOFINIO-T030-CLOSE-DT        PIC 9(6).              CSOFINIO
040900         05  FILLER                        PIC X(06).             CSOFINIO
041000                                                                  CSOFINIO
041100* RETURN OFIN SEGMENT - TRANSACTION TYPE 18                       CSOFINIO
041200     03  CSOFINIO-T031 REDEFINES CSOFINIO-T030.                   CSOFINIO
041300         05  CSOFINIO-T031-PAY-TYPE        PIC X(3).              CSOFINIO
041400         05  CSOFINIO-T031-DISB-DT         PIC 9(6).              CSOFINIO
041500         05  FILLER                        PIC X(4).              CSOFINIO
041600         05  CSOFINIO-T031-REIMBRSE-AMT    PIC S9(5)V99 COMP-3.   CSOFINIO
041700         05  CSOFINIO-T031-CLOSE-DT        PIC 9(6).              CSOFINIO
041800         05  CSOFINIO-T031-PAY-SOURCE      PIC X.                 CSOFINIO
041900         05  CSOFINIO-T031-DESC            PIC X(8).              CSOFINIO
042000         05  CSOFINIO-T031-DESC-ADJ REDEFINES                     CSOFINIO
042100               CSOFINIO-T031-DESC.                                CSOFINIO
042200             07  CSOFINIO-T031-DESC-ACT-CODE PIC XX.              CSOFINIO
042300             07  CSOFINIO-T031-TRAN-ADJ-DT   PIC 9(6).            CSOFINIO
042400         05  CSOFINIO-T031-BATCH-NO        PIC X(3).              CSOFINIO
042500         05  CSOFINIO-T031-SEQ-NO          PIC X(3).              CSOFINIO
042600         05  CSOFINIO-T031-PROCESS-DT      PIC 9(6).              CSOFINIO
042700         05  FILLER                        PIC X(9).              CSOFINIO
042800                                                                  CSOFINIO
042900* BALANCE OFIN HEADER - TRANSACTION TYPE 19                       CSOFINIO
043000     03  CSOFINIO-T032 REDEFINES CSOFINIO-T031.                   CSOFINIO
043100         05  CSOFINIO-T032-OLD-TOT-PAID    PIC S9(7)V99 COMP-3.   CSOFINIO
043200         05  CSOFINIO-T032-NEW-TOT-PAID    PIC S9(7)V99 COMP-3.   CSOFINIO
043300         05  CSOFINIO-T032-OLD-TOT-MOD     PIC S9(7)V99 COMP-3.   CSOFINIO
043400         05  CSOFINIO-T032-NEW-TOT-MOD     PIC S9(7)V99 COMP-3.   CSOFINIO
043500         05  FILLER                        PIC X(33).             CSOFINIO
043600                                                                  CSOFINIO
043700* BALANCE OFIN DETAIL - TRANSACTION TYPE 19                       CSOFINIO
043800     03  CSOFINIO-T033 REDEFINES CSOFINIO-T032.                   CSOFINIO
043900         05  CSOFINIO-T033-PAY-TYPE        PIC X(3).              CSOFINIO
044000         05  CSOFINIO-T033-ALT-PAYEE       PIC X(10).             CSOFINIO
044100         05  CSOFINIO-T033-OLD-BAL-AMT     PIC S9(7)V99 COMP-3.   CSOFINIO
044200         05  CSOFINIO-T033-NEW-BAL-AMT     PIC S9(7)V99 COMP-3.   CSOFINIO
044300         05  CSOFINIO-T033-OLD-MO-TO-DT    PIC S9(5)V99 COMP-3.   CSOFINIO
044400         05  CSOFINIO-T033-NEW-MO-TO-DT    PIC S9(5)V99 COMP-3.   CSOFINIO
044500         05  CSOFINIO-T033-OLD-YR-TO-DT    PIC S9(5)V99 COMP-3.   CSOFINIO
044600         05  CSOFINIO-T033-NEW-YR-TO-DT    PIC S9(5)V99 COMP-3.   CSOFINIO
044700         05  CSOFINIO-T033-OLD-TOT-TO-DT   PIC S9(5)V99 COMP-3.   CSOFINIO
044800         05  CSOFINIO-T033-NEW-TOT-TO-DT   PIC S9(5)V99 COMP-3.   CSOFINIO
044900         05  FILLER                        PIC X(6).              CSOFINIO
045000
045100* REPLACE OFIN DETAIL - TRANSACTION TYPE 20                       CSOFINIO
045200     03  CSOFINIO-T034 REDEFINES CSOFINIO-T033.                   CSOFINIO
045300         05  FILLER                        PIC X(3).              CSOFINIO
045400         05  CSOFINIO-T034-ALT-PAYEE-ID    PIC X(10).             CSOFINIO
045500         05  CSOFINIO-T034-REPL-AMT        PIC S9(5)V99 COMP-3.   CSOFINIO
045600         05  FILLER                        PIC X(36).             CSOFINIO
045700
045800* COMMENT OFIN - TRANSACTION TYPE 99                              CSOFINIO
045900     03  CSOFINIO-T099 REDEFINES CSOFINIO-T033.                   CSOFINIO
046000         05  CSOFINIO-T099-COMMENT         PIC X(53).             CSOFINIO
