.class public Lcom/google/xinoshell/utils/SmsHelper;
.super Ljava/lang/Object;
.source "SmsHelper.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "SmsHelper"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static sendSmsWithSim(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)Z
    .locals 12
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "from"    # I
    .param p2, "phoneNumber"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;

    .line 17
    const/4 v7, 0x0

    const-string v8, "SmsHelper"

    if-nez p0, :cond_0

    .line 18
    :try_start_0
    const-string v0, "Context cannot be null"

    invoke-static {v8, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 19
    return v7

    .line 22
    :cond_0
    if-eqz p2, :cond_8

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    move-object v2, p2

    goto/16 :goto_4

    .line 27
    :cond_1
    if-eqz p3, :cond_7

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    move-object v2, p2

    goto/16 :goto_3

    .line 33
    :cond_2
    const-string v0, "telephony_subscription_service"

    .line 34
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/SubscriptionManager;

    move-object v9, v0

    .line 35
    .local v9, "subscriptionManager":Landroid/telephony/SubscriptionManager;
    if-nez v9, :cond_3

    .line 36
    const-string v0, "Cannot get SubscriptionManager service"

    invoke-static {v8, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 37
    return v7

    .line 41
    :cond_3
    invoke-virtual {v9}, Landroid/telephony/SubscriptionManager;->getActiveSubscriptionInfoList()Ljava/util/List;

    move-result-object v0

    move-object v10, v0

    .line 42
    .local v10, "subscriptionList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubscriptionInfo;>;"
    if-eqz v10, :cond_6

    invoke-interface {v10}, Ljava/util/List;->isEmpty()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    if-eqz v0, :cond_4

    move-object v2, p2

    goto/16 :goto_2

    .line 49
    :cond_4
    const/4 v11, 0x1

    if-ltz p1, :cond_5

    :try_start_1
    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_5

    .line 50
    invoke-interface {v10, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/SubscriptionInfo;

    .line 51
    .local v0, "subscription":Landroid/telephony/SubscriptionInfo;
    invoke-virtual {v0}, Landroid/telephony/SubscriptionInfo;->getSubscriptionId()I

    move-result v1

    invoke-static {v1}, Landroid/telephony/SmsManager;->getSmsManagerForSubscriptionId(I)Landroid/telephony/SmsManager;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_4

    .line 52
    .local v1, "smsManager":Landroid/telephony/SmsManager;
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v3, 0x0

    move-object v2, p2

    move-object v4, p3

    :try_start_2
    invoke-virtual/range {v1 .. v6}, Landroid/telephony/SmsManager;->sendTextMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V

    .line 53
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SMS sent successfully using SIM "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    add-int/lit8 v4, p1, 0x1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " to: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v8, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_6

    .line 54
    return v11

    .line 56
    .end local v0    # "subscription":Landroid/telephony/SubscriptionInfo;
    .end local v1    # "smsManager":Landroid/telephony/SmsManager;
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    move-object v2, p2

    .line 57
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    :try_start_3
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to send SMS using selected SIM "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    add-int/lit8 v3, p1, 0x1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ", will try default SIM"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v8, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_6
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_5

    goto :goto_1

    .line 49
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_5
    move-object v2, p2

    .line 58
    nop

    .line 62
    :goto_1
    :try_start_4
    invoke-static {}, Landroid/telephony/SmsManager;->getDefault()Landroid/telephony/SmsManager;

    move-result-object v1

    .line 63
    .restart local v1    # "smsManager":Landroid/telephony/SmsManager;
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v3, 0x0

    move-object v4, p3

    invoke-virtual/range {v1 .. v6}, Landroid/telephony/SmsManager;->sendTextMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V

    .line 64
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SMS sent successfully using default SIM to: "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v8, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/lang/SecurityException; {:try_start_4 .. :try_end_4} :catch_6

    .line 65
    return v11

    .line 66
    .end local v1    # "smsManager":Landroid/telephony/SmsManager;
    :catch_2
    move-exception v0

    .line 67
    .restart local v0    # "e":Ljava/lang/Exception;
    :try_start_5
    const-string v1, "Failed to send SMS using default SIM"

    invoke-static {v8, v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 68
    return v7

    .line 42
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_6
    move-object v2, p2

    .line 43
    :goto_2
    const-string v0, "No active SIM cards found"

    invoke-static {v8, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 44
    return v7

    .line 27
    .end local v9    # "subscriptionManager":Landroid/telephony/SubscriptionManager;
    .end local v10    # "subscriptionList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubscriptionInfo;>;"
    :cond_7
    move-object v2, p2

    .line 28
    :goto_3
    const-string v0, "Invalid message"

    invoke-static {v8, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 29
    return v7

    .line 74
    :catch_3
    move-exception v0

    move-object v2, p2

    goto :goto_5

    .line 71
    :catch_4
    move-exception v0

    move-object v2, p2

    goto :goto_6

    .line 22
    :cond_8
    move-object v2, p2

    .line 23
    :goto_4
    const-string v0, "Invalid phone number"

    invoke-static {v8, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_5
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_6
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_5

    .line 24
    return v7

    .line 74
    :catch_5
    move-exception v0

    .line 75
    .restart local v0    # "e":Ljava/lang/Exception;
    :goto_5
    const-string v1, "Unexpected error while sending SMS"

    invoke-static {v8, v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 76
    return v7

    .line 71
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_6
    move-exception v0

    .line 72
    .local v0, "e":Ljava/lang/SecurityException;
    :goto_6
    const-string v1, "Permission denied for sending SMS"

    invoke-static {v8, v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 73
    return v7
.end method
