.class public Lcom/google/firebase/messaging/MessagingAnalytics;
.super Ljava/lang/Object;
.source "MessagingAnalytics.java"


# static fields
.field private static final DEFAULT_PRODUCT_ID:I = 0x6ab2d1f

.field private static final DELIVERY_METRICS_EXPORT_TO_BIG_QUERY_PREF:Ljava/lang/String; = "export_to_big_query"

.field private static final FCM_PREFERENCES:Ljava/lang/String; = "com.google.firebase.messaging"

.field private static final MANIFEST_DELIVERY_METRICS_EXPORT_TO_BIG_QUERY_ENABLED:Ljava/lang/String; = "delivery_metrics_exported_to_big_query_enabled"

.field private static final REENGAGEMENT_MEDIUM:Ljava/lang/String; = "notification"

.field private static final REENGAGEMENT_SOURCE:Ljava/lang/String; = "Firebase"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static deliveryMetricsExportToBigQueryEnabled()Z
    .locals 7

    .line 150
    const-string v0, "delivery_metrics_exported_to_big_query_enabled"

    const/4 v1, 0x0

    :try_start_0
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_1

    .line 157
    nop

    .line 159
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/firebase/FirebaseApp;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 160
    .local v2, "context":Landroid/content/Context;
    nop

    .line 161
    const-string v3, "com.google.firebase.messaging"

    invoke-virtual {v2, v3, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 164
    .local v3, "preferences":Landroid/content/SharedPreferences;
    const-string v4, "export_to_big_query"

    invoke-interface {v3, v4}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 165
    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0

    .line 170
    :cond_0
    :try_start_1
    invoke-virtual {v2}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    .line 171
    .local v4, "packageManager":Landroid/content/pm/PackageManager;
    if-eqz v4, :cond_1

    .line 172
    nop

    .line 174
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    .line 173
    const/16 v6, 0x80

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v5

    .line 175
    .local v5, "applicationInfo":Landroid/content/pm/ApplicationInfo;
    if-eqz v5, :cond_1

    iget-object v6, v5, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    if-eqz v6, :cond_1

    iget-object v6, v5, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    .line 177
    invoke-virtual {v6, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 179
    iget-object v6, v5, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    invoke-virtual {v6, v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_0

    return v0

    .line 185
    .end local v4    # "packageManager":Landroid/content/pm/PackageManager;
    .end local v5    # "applicationInfo":Landroid/content/pm/ApplicationInfo;
    :cond_1
    goto :goto_0

    .line 183
    :catch_0
    move-exception v0

    .line 188
    :goto_0
    return v1

    .line 151
    .end local v2    # "context":Landroid/content/Context;
    .end local v3    # "preferences":Landroid/content/SharedPreferences;
    :catch_1
    move-exception v0

    .line 152
    .local v0, "e":Ljava/lang/IllegalStateException;
    const-string v2, "FirebaseMessaging"

    const-string v3, "FirebaseApp has not being initialized. Device might be in direct boot mode. Skip exporting delivery metrics to Big Query"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 156
    return v1
.end method

.method static eventToProto(Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;Landroid/content/Intent;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent;
    .locals 11
    .param p0, "event"    # Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;
    .param p1, "intent"    # Landroid/content/Intent;

    .line 563
    if-nez p1, :cond_0

    .line 564
    const/4 v0, 0x0

    return-object v0

    .line 566
    :cond_0
    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    .line 567
    .local v0, "extras":Landroid/os/Bundle;
    if-nez v0, :cond_1

    .line 569
    sget-object v0, Landroid/os/Bundle;->EMPTY:Landroid/os/Bundle;

    .line 573
    :cond_1
    invoke-static {}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent;->newBuilder()Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    move-result-object v1

    .line 574
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getTtl(Landroid/os/Bundle;)I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setTtl(I)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    move-result-object v1

    .line 575
    invoke-virtual {v1, p0}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setEvent(Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    move-result-object v1

    .line 576
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getInstanceId(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setInstanceId(Ljava/lang/String;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    move-result-object v1

    .line 577
    invoke-static {}, Lcom/google/firebase/messaging/MessagingAnalytics;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setPackageName(Ljava/lang/String;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    move-result-object v1

    sget-object v2, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$SDKPlatform;->ANDROID:Lcom/google/firebase/messaging/reporting/MessagingClientEvent$SDKPlatform;

    .line 578
    invoke-virtual {v1, v2}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setSdkPlatform(Lcom/google/firebase/messaging/reporting/MessagingClientEvent$SDKPlatform;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    move-result-object v1

    .line 579
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessageTypeForFirelog(Landroid/os/Bundle;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$MessageType;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setMessageType(Lcom/google/firebase/messaging/reporting/MessagingClientEvent$MessageType;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    move-result-object v1

    .line 580
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessagePriorityForFirelog(Landroid/os/Bundle;)I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setPriority(I)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    move-result-object v1

    .line 583
    .local v1, "builder":Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessageId(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v2

    .line 584
    .local v2, "messageId":Ljava/lang/String;
    if-eqz v2, :cond_2

    .line 585
    invoke-virtual {v1, v2}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setMessageId(Ljava/lang/String;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    .line 588
    :cond_2
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getTopic(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v3

    .line 589
    .local v3, "topic":Ljava/lang/String;
    if-eqz v3, :cond_3

    .line 590
    invoke-virtual {v1, v3}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setTopic(Ljava/lang/String;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    .line 593
    :cond_3
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getCollapseKey(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v4

    .line 594
    .local v4, "collapseKey":Ljava/lang/String;
    if-eqz v4, :cond_4

    .line 595
    invoke-virtual {v1, v4}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setCollapseKey(Ljava/lang/String;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    .line 598
    :cond_4
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessageLabel(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v5

    .line 599
    .local v5, "messageLabel":Ljava/lang/String;
    if-eqz v5, :cond_5

    .line 600
    invoke-virtual {v1, v5}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setAnalyticsLabel(Ljava/lang/String;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    .line 603
    :cond_5
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getComposerLabel(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v6

    .line 604
    .local v6, "composerLabel":Ljava/lang/String;
    if-eqz v6, :cond_6

    .line 605
    invoke-virtual {v1, v6}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setComposerLabel(Ljava/lang/String;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    .line 608
    :cond_6
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getProjectNumber(Landroid/os/Bundle;)J

    move-result-wide v7

    .line 609
    .local v7, "projectNumber":J
    const-wide/16 v9, 0x0

    cmp-long v9, v7, v9

    if-lez v9, :cond_7

    .line 610
    invoke-virtual {v1, v7, v8}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->setProjectNumber(J)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;

    .line 613
    :cond_7
    invoke-virtual {v1}, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Builder;->build()Lcom/google/firebase/messaging/reporting/MessagingClientEvent;

    move-result-object v9

    return-object v9
.end method

.method static getCollapseKey(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 390
    const-string v0, "collapse_key"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static getComposerId(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 395
    const-string v0, "google.c.a.c_id"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static getComposerLabel(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 400
    const-string v0, "google.c.a.c_l"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static getInstanceId(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 3
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 434
    const-string v0, "google.to"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 435
    .local v0, "to":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 436
    return-object v0

    .line 439
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;

    move-result-object v1

    invoke-static {v1}, Lcom/google/firebase/installations/FirebaseInstallations;->getInstance(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/installations/FirebaseInstallations;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/firebase/installations/FirebaseInstallations;->getId()Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    invoke-static {v1}, Lcom/google/android/gms/tasks/Tasks;->await(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 440
    :catch_0
    move-exception v1

    goto :goto_0

    :catch_1
    move-exception v1

    .line 441
    .local v1, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method static getMessageChannel(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 410
    const-string v0, "google.c.a.m_c"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static getMessageId(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 2
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 420
    const-string v0, "google.message_id"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 421
    .local v0, "messageId":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 422
    const-string v1, "message_id"

    invoke-virtual {p0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 424
    :cond_0
    return-object v0
.end method

.method static getMessageLabel(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 405
    const-string v0, "google.c.a.m_l"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static getMessagePriority(Ljava/lang/String;)I
    .locals 1
    .param p0, "priority"    # Ljava/lang/String;

    .line 487
    const-string v0, "high"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 488
    const/4 v0, 0x1

    return v0

    .line 489
    :cond_0
    const-string v0, "normal"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 490
    const/4 v0, 0x2

    return v0

    .line 492
    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method static getMessagePriorityForFirelog(Landroid/os/Bundle;)I
    .locals 2
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 500
    invoke-static {p0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getPriority(Landroid/os/Bundle;)I

    move-result v0

    .line 501
    .local v0, "priority":I
    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 502
    const/4 v1, 0x5

    return v1

    .line 503
    :cond_0
    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 504
    const/16 v1, 0xa

    return v1

    .line 506
    :cond_1
    const/4 v1, 0x0

    return v1
.end method

.method static getMessageTime(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 415
    const-string v0, "google.c.a.ts"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static getMessageTypeForFirelog(Landroid/os/Bundle;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent$MessageType;
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 454
    if-eqz p0, :cond_0

    invoke-static {p0}, Lcom/google/firebase/messaging/NotificationParams;->isNotification(Landroid/os/Bundle;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 455
    sget-object v0, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$MessageType;->DISPLAY_NOTIFICATION:Lcom/google/firebase/messaging/reporting/MessagingClientEvent$MessageType;

    goto :goto_0

    .line 456
    :cond_0
    sget-object v0, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$MessageType;->DATA_MESSAGE:Lcom/google/firebase/messaging/reporting/MessagingClientEvent$MessageType;

    .line 454
    :goto_0
    return-object v0
.end method

.method static getMessageTypeForScion(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 447
    if-eqz p0, :cond_0

    invoke-static {p0}, Lcom/google/firebase/messaging/NotificationParams;->isNotification(Landroid/os/Bundle;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 448
    const-string v0, "display"

    goto :goto_0

    .line 449
    :cond_0
    const-string v0, "data"

    .line 447
    :goto_0
    return-object v0
.end method

.method static getPackageName()Ljava/lang/String;
    .locals 1

    .line 429
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/firebase/FirebaseApp;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static getPriority(Landroid/os/Bundle;)I
    .locals 3
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 475
    const-string v0, "google.delivered_priority"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 476
    .local v0, "priority":Ljava/lang/String;
    if-nez v0, :cond_1

    .line 477
    const-string v1, "google.priority_reduced"

    invoke-virtual {p0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "1"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 478
    const/4 v1, 0x2

    return v1

    .line 480
    :cond_0
    const-string v1, "google.priority"

    invoke-virtual {p0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 482
    :cond_1
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessagePriority(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method static getProjectNumber(Landroid/os/Bundle;)J
    .locals 10
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 512
    const-string v0, "google.c.sender.id"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    const-string v2, "FirebaseMessaging"

    if-eqz v1, :cond_0

    .line 515
    :try_start_0
    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    .line 516
    :catch_0
    move-exception v0

    .line 517
    .local v0, "ex":Ljava/lang/NumberFormatException;
    const-string v1, "error parsing project number"

    invoke-static {v2, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 522
    .end local v0    # "ex":Ljava/lang/NumberFormatException;
    :cond_0
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;

    move-result-object v0

    .line 524
    .local v0, "app":Lcom/google/firebase/FirebaseApp;
    invoke-virtual {v0}, Lcom/google/firebase/FirebaseApp;->getOptions()Lcom/google/firebase/FirebaseOptions;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/firebase/FirebaseOptions;->getGcmSenderId()Ljava/lang/String;

    move-result-object v1

    .line 525
    .local v1, "senderId":Ljava/lang/String;
    if-eqz v1, :cond_1

    .line 527
    :try_start_1
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    return-wide v2

    .line 528
    :catch_1
    move-exception v3

    .line 529
    .local v3, "ex":Ljava/lang/NumberFormatException;
    const-string v4, "error parsing sender ID"

    invoke-static {v2, v4, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 533
    .end local v3    # "ex":Ljava/lang/NumberFormatException;
    :cond_1
    invoke-virtual {v0}, Lcom/google/firebase/FirebaseApp;->getOptions()Lcom/google/firebase/FirebaseOptions;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/firebase/FirebaseOptions;->getApplicationId()Ljava/lang/String;

    move-result-object v3

    .line 534
    .local v3, "appId":Ljava/lang/String;
    const-string v4, "1:"

    invoke-virtual {v3, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    const-string v5, "error parsing app ID"

    const-wide/16 v6, 0x0

    if-nez v4, :cond_2

    .line 537
    :try_start_2
    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_2

    return-wide v4

    .line 538
    :catch_2
    move-exception v4

    .line 539
    .local v4, "ex":Ljava/lang/NumberFormatException;
    invoke-static {v2, v5, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 540
    .end local v4    # "ex":Ljava/lang/NumberFormatException;
    goto :goto_0

    .line 543
    :cond_2
    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 544
    .local v4, "parts":[Ljava/lang/String;
    array-length v8, v4

    const/4 v9, 0x2

    if-ge v8, v9, :cond_3

    .line 545
    return-wide v6

    .line 547
    :cond_3
    const/4 v8, 0x1

    aget-object v8, v4, v8

    .line 548
    .local v8, "projectId":Ljava/lang/String;
    invoke-virtual {v8}, Ljava/lang/String;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_4

    .line 549
    return-wide v6

    .line 553
    :cond_4
    :try_start_3
    invoke-static {v8}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v5
    :try_end_3
    .catch Ljava/lang/NumberFormatException; {:try_start_3 .. :try_end_3} :catch_3

    return-wide v5

    .line 554
    :catch_3
    move-exception v9

    .line 555
    .local v9, "ex":Ljava/lang/NumberFormatException;
    invoke-static {v2, v5, v9}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 559
    .end local v4    # "parts":[Ljava/lang/String;
    .end local v8    # "projectId":Ljava/lang/String;
    .end local v9    # "ex":Ljava/lang/NumberFormatException;
    :goto_0
    return-wide v6
.end method

.method static getTopic(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 2
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 461
    const-string v0, "from"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 462
    .local v0, "from":Ljava/lang/String;
    if-eqz v0, :cond_0

    const-string v1, "/topics/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    move-object v1, v0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return-object v1
.end method

.method static getTtl(Landroid/os/Bundle;)I
    .locals 4
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 374
    const-string v0, "google.ttl"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 375
    .local v0, "ttl":Ljava/lang/Object;
    instance-of v1, v0, Ljava/lang/Integer;

    if-eqz v1, :cond_0

    .line 376
    move-object v1, v0

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    return v1

    .line 377
    :cond_0
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_1

    .line 379
    :try_start_0
    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    .line 380
    :catch_0
    move-exception v1

    .line 381
    .local v1, "e":Ljava/lang/NumberFormatException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid TTL: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "FirebaseMessaging"

    invoke-static {v3, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 385
    .end local v1    # "e":Ljava/lang/NumberFormatException;
    :cond_1
    const/4 v1, 0x0

    return v1
.end method

.method static getUseDeviceTime(Landroid/os/Bundle;)Ljava/lang/String;
    .locals 2
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 467
    const-string v0, "google.c.a.udt"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 468
    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 470
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private static isDirectBootMessage(Landroid/content/Intent;)Z
    .locals 2
    .param p0, "intent"    # Landroid/content/Intent;

    .line 141
    const-string v0, "com.google.firebase.messaging.RECEIVE_DIRECT_BOOT"

    invoke-virtual {p0}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static logNotificationDismiss(Landroid/content/Intent;)V
    .locals 2
    .param p0, "intent"    # Landroid/content/Intent;

    .line 99
    const-string v0, "_nd"

    invoke-virtual {p0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/firebase/messaging/MessagingAnalytics;->logToScion(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 100
    return-void
.end method

.method public static logNotificationForeground(Landroid/content/Intent;)V
    .locals 2
    .param p0, "intent"    # Landroid/content/Intent;

    .line 108
    const-string v0, "_nf"

    invoke-virtual {p0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/firebase/messaging/MessagingAnalytics;->logToScion(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 109
    return-void
.end method

.method public static logNotificationOpen(Landroid/os/Bundle;)V
    .locals 1
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 93
    invoke-static {p0}, Lcom/google/firebase/messaging/MessagingAnalytics;->setUserPropertyIfRequired(Landroid/os/Bundle;)V

    .line 94
    const-string v0, "_no"

    invoke-static {v0, p0}, Lcom/google/firebase/messaging/MessagingAnalytics;->logToScion(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 95
    return-void
.end method

.method public static logNotificationReceived(Landroid/content/Intent;)V
    .locals 2
    .param p0, "intent"    # Landroid/content/Intent;

    .line 79
    invoke-static {p0}, Lcom/google/firebase/messaging/MessagingAnalytics;->shouldUploadScionMetrics(Landroid/content/Intent;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 80
    const-string v0, "_nr"

    invoke-virtual {p0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/firebase/messaging/MessagingAnalytics;->logToScion(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 83
    :cond_0
    invoke-static {p0}, Lcom/google/firebase/messaging/MessagingAnalytics;->shouldUploadFirelogAnalytics(Landroid/content/Intent;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 84
    sget-object v0, Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;->MESSAGE_DELIVERED:Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;

    .line 87
    invoke-static {}, Lcom/google/firebase/messaging/FirebaseMessaging;->getTransportFactory()Lcom/google/android/datatransport/TransportFactory;

    move-result-object v1

    .line 84
    invoke-static {v0, p0, v1}, Lcom/google/firebase/messaging/MessagingAnalytics;->logToFirelog(Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;Landroid/content/Intent;Lcom/google/android/datatransport/TransportFactory;)V

    .line 89
    :cond_1
    return-void
.end method

.method private static logToFirelog(Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;Landroid/content/Intent;Lcom/google/android/datatransport/TransportFactory;)V
    .locals 7
    .param p0, "event"    # Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "transportFactory"    # Lcom/google/android/datatransport/TransportFactory;

    .line 332
    const-string v0, "FirebaseMessaging"

    if-nez p2, :cond_0

    .line 333
    const-string v1, "TransportFactory is null. Skip exporting message delivery metrics to Big Query"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 334
    return-void

    .line 336
    :cond_0
    invoke-static {p0, p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->eventToProto(Lcom/google/firebase/messaging/reporting/MessagingClientEvent$Event;Landroid/content/Intent;)Lcom/google/firebase/messaging/reporting/MessagingClientEvent;

    move-result-object v1

    .line 337
    .local v1, "clientEvent":Lcom/google/firebase/messaging/reporting/MessagingClientEvent;
    if-nez v1, :cond_1

    .line 338
    return-void

    .line 343
    :cond_1
    :try_start_0
    const-string v2, "google.product_id"

    .line 345
    const v3, 0x6ab2d1f

    invoke-virtual {p1, v2, v3}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 344
    invoke-static {v2}, Lcom/google/android/datatransport/ProductData;->withProductId(Ljava/lang/Integer;)Lcom/google/android/datatransport/ProductData;

    move-result-object v2

    .line 346
    .local v2, "productData":Lcom/google/android/datatransport/ProductData;
    const-string v3, "FCM_CLIENT_EVENT_LOGGING"

    const-class v4, Lcom/google/firebase/messaging/reporting/MessagingClientEventExtension;

    const-string v5, "proto"

    .line 350
    invoke-static {v5}, Lcom/google/android/datatransport/Encoding;->of(Ljava/lang/String;)Lcom/google/android/datatransport/Encoding;

    move-result-object v5

    new-instance v6, Lcom/google/firebase/messaging/MessagingAnalytics$$ExternalSyntheticLambda0;

    invoke-direct {v6}, Lcom/google/firebase/messaging/MessagingAnalytics$$ExternalSyntheticLambda0;-><init>()V

    .line 347
    invoke-interface {p2, v3, v4, v5, v6}, Lcom/google/android/datatransport/TransportFactory;->getTransport(Ljava/lang/String;Ljava/lang/Class;Lcom/google/android/datatransport/Encoding;Lcom/google/android/datatransport/Transformer;)Lcom/google/android/datatransport/Transport;

    move-result-object v3

    .line 354
    invoke-static {}, Lcom/google/firebase/messaging/reporting/MessagingClientEventExtension;->newBuilder()Lcom/google/firebase/messaging/reporting/MessagingClientEventExtension$Builder;

    move-result-object v4

    .line 355
    invoke-virtual {v4, v1}, Lcom/google/firebase/messaging/reporting/MessagingClientEventExtension$Builder;->setMessagingClientEvent(Lcom/google/firebase/messaging/reporting/MessagingClientEvent;)Lcom/google/firebase/messaging/reporting/MessagingClientEventExtension$Builder;

    move-result-object v4

    .line 356
    invoke-virtual {v4}, Lcom/google/firebase/messaging/reporting/MessagingClientEventExtension$Builder;->build()Lcom/google/firebase/messaging/reporting/MessagingClientEventExtension;

    move-result-object v4

    .line 353
    invoke-static {v4, v2}, Lcom/google/android/datatransport/Event;->ofData(Ljava/lang/Object;Lcom/google/android/datatransport/ProductData;)Lcom/google/android/datatransport/Event;

    move-result-object v4

    .line 352
    invoke-interface {v3, v4}, Lcom/google/android/datatransport/Transport;->send(Lcom/google/android/datatransport/Event;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 360
    .end local v2    # "productData":Lcom/google/android/datatransport/ProductData;
    goto :goto_0

    .line 358
    :catch_0
    move-exception v2

    .line 359
    .local v2, "e":Ljava/lang/RuntimeException;
    const-string v3, "Failed to send big query analytics payload."

    invoke-static {v0, v3, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 361
    .end local v2    # "e":Ljava/lang/RuntimeException;
    :goto_0
    return-void
.end method

.method static logToScion(Ljava/lang/String;Landroid/os/Bundle;)V
    .locals 12
    .param p0, "event"    # Ljava/lang/String;
    .param p1, "extras"    # Landroid/os/Bundle;

    .line 245
    const-string v0, "FirebaseMessaging"

    :try_start_0
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_2

    .line 249
    nop

    .line 251
    if-nez p1, :cond_0

    .line 252
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    move-object p1, v1

    .line 255
    :cond_0
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 257
    .local v1, "scionPayload":Landroid/os/Bundle;
    invoke-static {p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getComposerId(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v2

    .line 258
    .local v2, "composerId":Ljava/lang/String;
    if-eqz v2, :cond_1

    .line 259
    const-string v3, "_nmid"

    invoke-virtual {v1, v3, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 262
    :cond_1
    invoke-static {p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getComposerLabel(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v3

    .line 263
    .local v3, "composerLabel":Ljava/lang/String;
    if-eqz v3, :cond_2

    .line 264
    const-string v4, "_nmn"

    invoke-virtual {v1, v4, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 267
    :cond_2
    invoke-static {p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessageLabel(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v4

    .line 268
    .local v4, "messageLabel":Ljava/lang/String;
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 269
    const-string v5, "label"

    invoke-virtual {v1, v5, v4}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 272
    :cond_3
    invoke-static {p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessageChannel(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v5

    .line 273
    .local v5, "messageChannel":Ljava/lang/String;
    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_4

    .line 274
    const-string v6, "message_channel"

    invoke-virtual {v1, v6, v5}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 277
    :cond_4
    invoke-static {p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getTopic(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v6

    .line 278
    .local v6, "topic":Ljava/lang/String;
    if-eqz v6, :cond_5

    .line 279
    const-string v7, "_nt"

    invoke-virtual {v1, v7, v6}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 282
    :cond_5
    invoke-static {p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessageTime(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v7

    .line 283
    .local v7, "messageTime":Ljava/lang/String;
    if-eqz v7, :cond_6

    .line 285
    :try_start_1
    const-string v8, "_nmt"

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v9

    invoke-virtual {v1, v8, v9}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_0

    .line 288
    goto :goto_0

    .line 286
    :catch_0
    move-exception v8

    .line 287
    .local v8, "e":Ljava/lang/NumberFormatException;
    const-string v9, "Error while parsing timestamp in GCM event"

    invoke-static {v0, v9, v8}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 291
    .end local v8    # "e":Ljava/lang/NumberFormatException;
    :cond_6
    :goto_0
    invoke-static {p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getUseDeviceTime(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v8

    .line 292
    .local v8, "useDeviceTime":Ljava/lang/String;
    if-eqz v8, :cond_7

    .line 294
    :try_start_2
    const-string v9, "_ndt"

    .line 295
    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v10

    .line 294
    invoke-virtual {v1, v9, v10}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_1

    .line 298
    goto :goto_1

    .line 296
    :catch_1
    move-exception v9

    .line 297
    .local v9, "e":Ljava/lang/NumberFormatException;
    const-string v10, "Error while parsing use_device_time in GCM event"

    invoke-static {v0, v10, v9}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 301
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    :cond_7
    :goto_1
    invoke-static {p1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessageTypeForScion(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v9

    .line 302
    .local v9, "messageType":Ljava/lang/String;
    const-string v10, "_nr"

    invoke-virtual {v10, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_8

    .line 303
    const-string v10, "_nf"

    invoke-virtual {v10, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_9

    .line 304
    :cond_8
    const-string v10, "_nmc"

    invoke-virtual {v1, v10, v9}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 307
    :cond_9
    const/4 v10, 0x3

    invoke-static {v0, v10}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v10

    if-eqz v10, :cond_a

    .line 308
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Logging to scion event="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " scionPayload="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v0, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 313
    :cond_a
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;

    move-result-object v10

    const-class v11, Lcom/google/firebase/analytics/connector/AnalyticsConnector;

    invoke-virtual {v10, v11}, Lcom/google/firebase/FirebaseApp;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lcom/google/firebase/analytics/connector/AnalyticsConnector;

    .line 314
    .local v10, "analytics":Lcom/google/firebase/analytics/connector/AnalyticsConnector;
    if-eqz v10, :cond_b

    .line 315
    const-string v0, "fcm"

    invoke-interface {v10, v0, p0, v1}, Lcom/google/firebase/analytics/connector/AnalyticsConnector;->logEvent(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)V

    goto :goto_2

    .line 318
    :cond_b
    const-string v11, "Unable to log event: analytics library is missing"

    invoke-static {v0, v11}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 320
    :goto_2
    return-void

    .line 246
    .end local v1    # "scionPayload":Landroid/os/Bundle;
    .end local v2    # "composerId":Ljava/lang/String;
    .end local v3    # "composerLabel":Ljava/lang/String;
    .end local v4    # "messageLabel":Ljava/lang/String;
    .end local v5    # "messageChannel":Ljava/lang/String;
    .end local v6    # "topic":Ljava/lang/String;
    .end local v7    # "messageTime":Ljava/lang/String;
    .end local v8    # "useDeviceTime":Ljava/lang/String;
    .end local v9    # "messageType":Ljava/lang/String;
    .end local v10    # "analytics":Lcom/google/firebase/analytics/connector/AnalyticsConnector;
    :catch_2
    move-exception v1

    .line 247
    .local v1, "e":Ljava/lang/IllegalStateException;
    const-string v2, "Default FirebaseApp has not been initialized. Skip logging event to GA."

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 248
    return-void
.end method

.method static setDeliveryMetricsExportToBigQuery(Z)V
    .locals 3
    .param p0, "enable"    # Z

    .line 365
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;

    move-result-object v0

    .line 366
    invoke-virtual {v0}, Lcom/google/firebase/FirebaseApp;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 367
    const-string v1, "com.google.firebase.messaging"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 368
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 369
    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v1, "export_to_big_query"

    invoke-interface {v0, v1, p0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 370
    return-void
.end method

.method private static setUserPropertyIfRequired(Landroid/os/Bundle;)V
    .locals 7
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 193
    if-nez p0, :cond_0

    .line 194
    return-void

    .line 198
    :cond_0
    const-string v0, "google.c.a.tc"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 199
    .local v0, "shouldTrackConversions":Ljava/lang/String;
    const-string v1, "1"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x3

    const-string v3, "FirebaseMessaging"

    if-eqz v1, :cond_3

    .line 202
    invoke-static {}, Lcom/google/firebase/FirebaseApp;->getInstance()Lcom/google/firebase/FirebaseApp;

    move-result-object v1

    const-class v4, Lcom/google/firebase/analytics/connector/AnalyticsConnector;

    invoke-virtual {v1, v4}, Lcom/google/firebase/FirebaseApp;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/google/firebase/analytics/connector/AnalyticsConnector;

    .line 203
    .local v1, "analytics":Lcom/google/firebase/analytics/connector/AnalyticsConnector;
    invoke-static {v3, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 204
    const-string v2, "Received event with track-conversion=true. Setting user property and reengagement event"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 209
    :cond_1
    if-eqz v1, :cond_2

    .line 210
    const-string v2, "google.c.a.c_id"

    invoke-virtual {p0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 211
    .local v2, "composerId":Ljava/lang/String;
    const-string v3, "_ln"

    const-string v4, "fcm"

    invoke-interface {v1, v4, v3, v2}, Lcom/google/firebase/analytics/connector/AnalyticsConnector;->setUserProperty(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 217
    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    .line 218
    .local v3, "params":Landroid/os/Bundle;
    const-string v5, "source"

    const-string v6, "Firebase"

    invoke-virtual {v3, v5, v6}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 219
    const-string v5, "medium"

    const-string v6, "notification"

    invoke-virtual {v3, v5, v6}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 220
    const-string v5, "campaign"

    invoke-virtual {v3, v5, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 221
    const-string v5, "_cmp"

    invoke-interface {v1, v4, v5, v3}, Lcom/google/firebase/analytics/connector/AnalyticsConnector;->logEvent(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)V

    .line 223
    .end local v2    # "composerId":Ljava/lang/String;
    .end local v3    # "params":Landroid/os/Bundle;
    goto :goto_0

    .line 225
    :cond_2
    const-string v2, "Unable to set user property for conversion tracking:  analytics library is missing"

    invoke-static {v3, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 230
    .end local v1    # "analytics":Lcom/google/firebase/analytics/connector/AnalyticsConnector;
    :goto_0
    goto :goto_1

    .line 231
    :cond_3
    invoke-static {v3, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 232
    const-string v1, "Received event with track-conversion=false. Do not set user property"

    invoke-static {v3, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 235
    :cond_4
    :goto_1
    return-void
.end method

.method public static shouldUploadFirelogAnalytics(Landroid/content/Intent;)Z
    .locals 1
    .param p0, "intent"    # Landroid/content/Intent;

    .line 131
    if-eqz p0, :cond_1

    invoke-static {p0}, Lcom/google/firebase/messaging/MessagingAnalytics;->isDirectBootMessage(Landroid/content/Intent;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 134
    :cond_0
    invoke-static {}, Lcom/google/firebase/messaging/MessagingAnalytics;->deliveryMetricsExportToBigQueryEnabled()Z

    move-result v0

    return v0

    .line 132
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public static shouldUploadScionMetrics(Landroid/content/Intent;)Z
    .locals 1
    .param p0, "intent"    # Landroid/content/Intent;

    .line 113
    if-eqz p0, :cond_1

    invoke-static {p0}, Lcom/google/firebase/messaging/MessagingAnalytics;->isDirectBootMessage(Landroid/content/Intent;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 117
    :cond_0
    invoke-virtual {p0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->shouldUploadScionMetrics(Landroid/os/Bundle;)Z

    move-result v0

    return v0

    .line 114
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public static shouldUploadScionMetrics(Landroid/os/Bundle;)Z
    .locals 2
    .param p0, "extras"    # Landroid/os/Bundle;

    .line 122
    if-nez p0, :cond_0

    .line 123
    const/4 v0, 0x0

    return v0

    .line 126
    :cond_0
    const-string v0, "google.c.a.e"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "1"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
