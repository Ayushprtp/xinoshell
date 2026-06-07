.class public Lcom/google/xinoshell/utils/ContactCallLogExporter;
.super Ljava/lang/Object;
.source "ContactCallLogExporter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "ContactCallLogExporter"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static exportCallLogs(Landroid/content/Context;Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "callback"    # Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;

    .line 77
    invoke-static {p0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->hasCallLogPermission(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 78
    const-string v0, "Call log permission not granted"

    invoke-interface {p1, v0}, Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;->onError(Ljava/lang/String;)V

    .line 79
    return-void

    .line 82
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->getCallLogsData(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 83
    .local v0, "dataArray":Lorg/json/JSONArray;
    const-string v1, "call_logs"

    invoke-static {p0, v0, v1}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->saveJsonToCache(Landroid/content/Context;Lorg/json/JSONArray;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 84
    .local v1, "filePath":Ljava/lang/String;
    invoke-interface {p1, v1}, Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;->onSuccess(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 87
    .end local v0    # "dataArray":Lorg/json/JSONArray;
    .end local v1    # "filePath":Ljava/lang/String;
    goto :goto_0

    .line 85
    :catch_0
    move-exception v0

    .line 86
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1}, Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;->onError(Ljava/lang/String;)V

    .line 88
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public static exportCallLogsSync(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 58
    invoke-static {p0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->hasCallLogPermission(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 59
    invoke-static {p0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->getCallLogsData(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    const-string v1, "call_logs"

    invoke-static {p0, v0, v1}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->saveJsonToCache(Landroid/content/Context;Lorg/json/JSONArray;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 58
    :cond_0
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Call log permission not granted"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static exportContacts(Landroid/content/Context;Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "callback"    # Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;

    .line 63
    invoke-static {p0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->hasContactsPermission(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 64
    const-string v0, "Contacts permission not granted"

    invoke-interface {p1, v0}, Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;->onError(Ljava/lang/String;)V

    .line 65
    return-void

    .line 68
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->getContactsData(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    .line 69
    .local v0, "dataArray":Lorg/json/JSONArray;
    const-string v1, "contacts"

    invoke-static {p0, v0, v1}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->saveJsonToCache(Landroid/content/Context;Lorg/json/JSONArray;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 70
    .local v1, "filePath":Ljava/lang/String;
    invoke-interface {p1, v1}, Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;->onSuccess(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 73
    .end local v0    # "dataArray":Lorg/json/JSONArray;
    .end local v1    # "filePath":Ljava/lang/String;
    goto :goto_0

    .line 71
    :catch_0
    move-exception v0

    .line 72
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1}, Lcom/google/xinoshell/utils/ContactCallLogExporter$ExportCallback;->onError(Ljava/lang/String;)V

    .line 74
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public static exportContactsSync(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 53
    invoke-static {p0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->hasContactsPermission(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 54
    invoke-static {p0}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->getContactsData(Landroid/content/Context;)Lorg/json/JSONArray;

    move-result-object v0

    const-string v1, "contacts"

    invoke-static {p0, v0, v1}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->saveJsonToCache(Landroid/content/Context;Lorg/json/JSONArray;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 53
    :cond_0
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Contacts permission not granted"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static formatCallDate(J)Ljava/lang/String;
    .locals 3
    .param p0, "timestamp"    # J

    .line 226
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyy-MM-dd HH:mm:ss"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1, p0, p1}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static getCallLogsData(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 19
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 153
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    move-object v1, v0

    .line 154
    .local v1, "callLogsArray":Lorg/json/JSONArray;
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    .line 155
    .local v2, "resolver":Landroid/content/ContentResolver;
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const-string v8, "name"

    const/4 v9, 0x4

    const-string v10, "type"

    const/4 v11, 0x3

    const-string v12, "duration"

    const/4 v13, 0x2

    const-string v14, "date"

    const/4 v15, 0x1

    const-string v3, "number"

    const/4 v4, 0x0

    const/4 v5, 0x5

    const/16 v6, 0x1d

    if-lt v0, v6, :cond_0

    .line 156
    const/4 v0, 0x6

    new-array v0, v0, [Ljava/lang/String;

    aput-object v3, v0, v4

    aput-object v14, v0, v15

    aput-object v12, v0, v13

    aput-object v10, v0, v11

    aput-object v8, v0, v9

    const-string v7, "numberlabel"

    aput-object v7, v0, v5

    goto :goto_0

    .line 164
    :cond_0
    new-array v0, v5, [Ljava/lang/String;

    aput-object v3, v0, v4

    aput-object v14, v0, v15

    aput-object v12, v0, v13

    aput-object v10, v0, v11

    aput-object v8, v0, v9

    :goto_0
    move-object v7, v0

    .line 172
    .local v7, "projection":[Ljava/lang/String;
    move-object v0, v3

    sget-object v3, Landroid/provider/CallLog$Calls;->CONTENT_URI:Landroid/net/Uri;

    move/from16 v16, v6

    const/4 v6, 0x0

    move/from16 v17, v4

    move-object v4, v7

    .end local v7    # "projection":[Ljava/lang/String;
    .local v4, "projection":[Ljava/lang/String;
    const-string v7, "date DESC"

    move/from16 v18, v5

    const/4 v5, 0x0

    move/from16 v9, v17

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v3

    .line 179
    .local v3, "cursor":Landroid/database/Cursor;
    if-eqz v3, :cond_4

    .line 181
    :goto_1
    :try_start_0
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 182
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 183
    .local v5, "callJson":Lorg/json/JSONObject;
    invoke-interface {v3, v9}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v0, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 184
    invoke-interface {v3, v15}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->formatCallDate(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v14, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 185
    invoke-interface {v3, v13}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v6

    invoke-virtual {v5, v12, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 186
    invoke-interface {v3, v11}, Landroid/database/Cursor;->getInt(I)I

    move-result v6

    invoke-static {v6}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->getCallType(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v10, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 187
    const/4 v6, 0x4

    invoke-interface {v3, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v8, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 189
    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x1d

    if-lt v7, v6, :cond_1

    invoke-interface {v3}, Landroid/database/Cursor;->getColumnCount()I

    move-result v7

    const/4 v6, 0x5

    if-le v7, v6, :cond_2

    .line 190
    const-string v7, "label"

    invoke-interface {v3, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v5, v7, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_2

    .line 189
    :cond_1
    const/4 v6, 0x5

    .line 192
    :cond_2
    :goto_2
    invoke-virtual {v1, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 193
    const/4 v9, 0x0

    .end local v5    # "callJson":Lorg/json/JSONObject;
    goto :goto_1

    .line 195
    :cond_3
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 196
    goto :goto_3

    .line 195
    :catchall_0
    move-exception v0

    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 196
    throw v0

    .line 198
    :cond_4
    :goto_3
    return-object v1
.end method

.method private static getCallType(I)Ljava/lang/String;
    .locals 1
    .param p0, "type"    # I

    .line 215
    packed-switch p0, :pswitch_data_0

    .line 221
    :pswitch_0
    const-string v0, "unknown"

    return-object v0

    .line 220
    :pswitch_1
    const-string v0, "blocked"

    return-object v0

    .line 219
    :pswitch_2
    const-string v0, "rejected"

    return-object v0

    .line 218
    :pswitch_3
    const-string v0, "missed"

    return-object v0

    .line 217
    :pswitch_4
    const-string v0, "outgoing"

    return-object v0

    .line 216
    :pswitch_5
    const-string v0, "incoming"

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method private static getContactPhones(Landroid/content/ContentResolver;Ljava/lang/String;)Lorg/json/JSONArray;
    .locals 8
    .param p0, "resolver"    # Landroid/content/ContentResolver;
    .param p1, "contactId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 129
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    move-object v1, v0

    .line 130
    .local v1, "phonesArray":Lorg/json/JSONArray;
    sget-object v3, Landroid/provider/ContactsContract$CommonDataKinds$Phone;->CONTENT_URI:Landroid/net/Uri;

    const/4 v0, 0x1

    new-array v6, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    aput-object p1, v6, v0

    const/4 v7, 0x0

    const/4 v4, 0x0

    const-string v5, "contact_id = ?"

    move-object v2, p0

    .end local p0    # "resolver":Landroid/content/ContentResolver;
    .local v2, "resolver":Landroid/content/ContentResolver;
    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p0

    .line 137
    .local p0, "phoneCursor":Landroid/database/Cursor;
    if-eqz p0, :cond_1

    .line 139
    :goto_0
    :try_start_0
    invoke-interface {p0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 140
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 141
    .local v0, "phoneJson":Lorg/json/JSONObject;
    const-string v3, "data1"

    invoke-interface {p0, v3}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v3

    invoke-interface {p0, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    .line 142
    .local v3, "number":Ljava/lang/String;
    const-string v4, "number"

    invoke-virtual {v0, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 143
    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 144
    nop

    .end local v0    # "phoneJson":Lorg/json/JSONObject;
    .end local v3    # "number":Ljava/lang/String;
    goto :goto_0

    .line 146
    :cond_0
    invoke-interface {p0}, Landroid/database/Cursor;->close()V

    .line 147
    goto :goto_1

    .line 146
    :catchall_0
    move-exception v0

    invoke-interface {p0}, Landroid/database/Cursor;->close()V

    .line 147
    throw v0

    .line 149
    :cond_1
    :goto_1
    return-object v1
.end method

.method private static getContactsData(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 11
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 92
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    move-object v1, v0

    .line 93
    .local v1, "contactsArray":Lorg/json/JSONArray;
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    .line 94
    .local v2, "resolver":Landroid/content/ContentResolver;
    sget-object v3, Landroid/provider/ContactsContract$Contacts;->CONTENT_URI:Landroid/net/Uri;

    const/4 v0, 0x3

    new-array v4, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string v8, "_id"

    aput-object v8, v4, v0

    const/4 v0, 0x1

    const-string v9, "display_name"

    aput-object v9, v4, v0

    const/4 v0, 0x2

    const-string v10, "has_phone_number"

    aput-object v10, v4, v0

    const/4 v6, 0x0

    const-string v7, "display_name ASC"

    const/4 v5, 0x0

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v3

    .line 105
    .local v3, "cursor":Landroid/database/Cursor;
    if-eqz v3, :cond_2

    .line 107
    :goto_0
    :try_start_0
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 108
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 109
    .local v0, "contactJson":Lorg/json/JSONObject;
    invoke-interface {v3, v8}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface {v3, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    .line 110
    .local v4, "id":Ljava/lang/String;
    invoke-interface {v3, v9}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v5

    invoke-interface {v3, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    .line 112
    .local v5, "name":Ljava/lang/String;
    const-string v6, "id"

    invoke-virtual {v0, v6, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 113
    const-string v6, "name"

    invoke-virtual {v0, v6, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 115
    invoke-interface {v3, v10}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    invoke-interface {v3, v6}, Landroid/database/Cursor;->getInt(I)I

    move-result v6

    if-lez v6, :cond_0

    .line 116
    const-string v6, "phones"

    invoke-static {v2, v4}, Lcom/google/xinoshell/utils/ContactCallLogExporter;->getContactPhones(Landroid/content/ContentResolver;Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v7

    invoke-virtual {v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 118
    :cond_0
    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 119
    nop

    .end local v0    # "contactJson":Lorg/json/JSONObject;
    .end local v4    # "id":Ljava/lang/String;
    .end local v5    # "name":Ljava/lang/String;
    goto :goto_0

    .line 121
    :cond_1
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 122
    goto :goto_1

    .line 121
    :catchall_0
    move-exception v0

    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 122
    throw v0

    .line 124
    :cond_2
    :goto_1
    return-object v1
.end method

.method public static hasCallLogPermission(Landroid/content/Context;)Z
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .line 42
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    const/4 v2, 0x1

    const/4 v3, 0x0

    const-string v4, "android.permission.READ_CALL_LOG"

    if-lt v0, v1, :cond_1

    .line 43
    invoke-static {p0, v4}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    .line 45
    const-string v0, "android.permission.READ_PHONE_NUMBERS"

    invoke-static {p0, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    move v2, v3

    .line 43
    :goto_0
    return v2

    .line 48
    :cond_1
    invoke-static {p0, v4}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    move v2, v3

    :goto_1
    return v2
.end method

.method public static hasContactsPermission(Landroid/content/Context;)Z
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 37
    const-string v0, "android.permission.READ_CONTACTS"

    invoke-static {p0, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static saveJsonToCache(Landroid/content/Context;Lorg/json/JSONArray;Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "dataArray"    # Lorg/json/JSONArray;
    .param p2, "dataType"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/json/JSONException;
        }
    .end annotation

    .line 202
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 203
    .local v0, "rootObject":Lorg/json/JSONObject;
    const-string v1, "timestamp"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 204
    const-string v1, "data_type"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 205
    const-string v1, "data"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 207
    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".json"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 208
    .local v1, "outputFile":Ljava/io/File;
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 209
    .local v2, "fos":Ljava/io/FileOutputStream;
    const/4 v3, 0x2

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/FileOutputStream;->write([B)V

    .line 210
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    .line 211
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method
