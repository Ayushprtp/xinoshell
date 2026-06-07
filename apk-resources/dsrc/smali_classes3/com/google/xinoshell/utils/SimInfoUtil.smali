.class public Lcom/google/xinoshell/utils/SimInfoUtil;
.super Ljava/lang/Object;
.source "SimInfoUtil.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getSim1(Landroid/content/Context;)Ljava/lang/String;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 59
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/google/xinoshell/utils/SimInfoUtil;->getSimNumber(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSim2(Landroid/content/Context;)Ljava/lang/String;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 63
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/google/xinoshell/utils/SimInfoUtil;->getSimNumber(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSimInfo(Landroid/content/Context;)Lorg/json/JSONArray;
    .locals 13
    .param p0, "context"    # Landroid/content/Context;

    .line 21
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 23
    .local v0, "simArray":Lorg/json/JSONArray;
    const-string v1, "android.permission.READ_PHONE_STATE"

    invoke-virtual {p0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    .line 24
    return-object v0

    .line 27
    :cond_0
    invoke-static {p0}, Landroid/telephony/SubscriptionManager;->from(Landroid/content/Context;)Landroid/telephony/SubscriptionManager;

    move-result-object v1

    .line 28
    .local v1, "subscriptionManager":Landroid/telephony/SubscriptionManager;
    const-string v2, "phone"

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/telephony/TelephonyManager;

    .line 29
    .local v2, "telephonyManager":Landroid/telephony/TelephonyManager;
    invoke-virtual {v1}, Landroid/telephony/SubscriptionManager;->getActiveSubscriptionInfoList()Ljava/util/List;

    move-result-object v3

    .line 31
    .local v3, "subInfoList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubscriptionInfo;>;"
    if-eqz v3, :cond_6

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_6

    .line 32
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_6

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/telephony/SubscriptionInfo;

    .line 33
    .local v5, "subscriptionInfo":Landroid/telephony/SubscriptionInfo;
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 35
    .local v6, "simObject":Lorg/json/JSONObject;
    invoke-virtual {v5}, Landroid/telephony/SubscriptionInfo;->getNumber()Ljava/lang/String;

    move-result-object v7

    .line 36
    .local v7, "number":Ljava/lang/String;
    if-eqz v7, :cond_1

    invoke-virtual {v7}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_2

    .line 37
    :cond_1
    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v7

    .line 39
    :cond_2
    invoke-virtual {v5}, Landroid/telephony/SubscriptionInfo;->getCarrierName()Ljava/lang/CharSequence;

    move-result-object v8

    const-string v9, "Unknown"

    if-eqz v8, :cond_3

    .line 40
    invoke-virtual {v5}, Landroid/telephony/SubscriptionInfo;->getCarrierName()Ljava/lang/CharSequence;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v8

    goto :goto_1

    :cond_3
    move-object v8, v9

    .line 41
    .local v8, "carrierName":Ljava/lang/String;
    :goto_1
    invoke-virtual {v5}, Landroid/telephony/SubscriptionInfo;->getSimSlotIndex()I

    move-result v10

    .line 44
    .local v10, "simSlotIndex":I
    :try_start_0
    const-string v11, "phoneNumber"

    if-eqz v7, :cond_5

    invoke-virtual {v7}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-eqz v12, :cond_4

    goto :goto_2

    :cond_4
    move-object v9, v7

    :cond_5
    :goto_2
    invoke-virtual {v6, v11, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 45
    const-string v9, "carrierName"

    invoke-virtual {v6, v9, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 46
    const-string v9, "simSlotIndex"

    invoke-virtual {v6, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 49
    nop

    .line 51
    invoke-virtual {v0, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 52
    .end local v5    # "subscriptionInfo":Landroid/telephony/SubscriptionInfo;
    .end local v6    # "simObject":Lorg/json/JSONObject;
    .end local v7    # "number":Ljava/lang/String;
    .end local v8    # "carrierName":Ljava/lang/String;
    .end local v10    # "simSlotIndex":I
    goto :goto_0

    .line 47
    .restart local v5    # "subscriptionInfo":Landroid/telephony/SubscriptionInfo;
    .restart local v6    # "simObject":Lorg/json/JSONObject;
    .restart local v7    # "number":Ljava/lang/String;
    .restart local v8    # "carrierName":Ljava/lang/String;
    .restart local v10    # "simSlotIndex":I
    :catch_0
    move-exception v4

    .line 48
    .local v4, "e":Lorg/json/JSONException;
    new-instance v9, Ljava/lang/RuntimeException;

    invoke-direct {v9, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v9

    .line 55
    .end local v4    # "e":Lorg/json/JSONException;
    .end local v5    # "subscriptionInfo":Landroid/telephony/SubscriptionInfo;
    .end local v6    # "simObject":Lorg/json/JSONObject;
    .end local v7    # "number":Ljava/lang/String;
    .end local v8    # "carrierName":Ljava/lang/String;
    .end local v10    # "simSlotIndex":I
    :cond_6
    return-object v0
.end method

.method private static getSimNumber(Landroid/content/Context;I)Ljava/lang/String;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "slotIndex"    # I

    .line 67
    invoke-static {p0}, Landroid/telephony/SubscriptionManager;->from(Landroid/content/Context;)Landroid/telephony/SubscriptionManager;

    move-result-object v0

    .line 68
    .local v0, "subscriptionManager":Landroid/telephony/SubscriptionManager;
    const-string v1, "android.permission.READ_PHONE_STATE"

    invoke-virtual {p0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    .line 69
    const/4 v1, 0x0

    return-object v1

    .line 71
    :cond_0
    invoke-virtual {v0}, Landroid/telephony/SubscriptionManager;->getActiveSubscriptionInfoList()Ljava/util/List;

    move-result-object v1

    .line 72
    .local v1, "subInfoList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubscriptionInfo;>;"
    const-string v2, "Not Found"

    if-eqz v1, :cond_4

    .line 73
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/telephony/SubscriptionInfo;

    .line 74
    .local v4, "info":Landroid/telephony/SubscriptionInfo;
    invoke-virtual {v4}, Landroid/telephony/SubscriptionInfo;->getSimSlotIndex()I

    move-result v5

    if-ne v5, p1, :cond_3

    .line 75
    invoke-virtual {v4}, Landroid/telephony/SubscriptionInfo;->getNumber()Ljava/lang/String;

    move-result-object v3

    .line 76
    .local v3, "number":Ljava/lang/String;
    if-eqz v3, :cond_2

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_1

    goto :goto_1

    :cond_1
    move-object v2, v3

    :cond_2
    :goto_1
    return-object v2

    .line 78
    .end local v3    # "number":Ljava/lang/String;
    .end local v4    # "info":Landroid/telephony/SubscriptionInfo;
    :cond_3
    goto :goto_0

    .line 80
    :cond_4
    return-object v2
.end method
