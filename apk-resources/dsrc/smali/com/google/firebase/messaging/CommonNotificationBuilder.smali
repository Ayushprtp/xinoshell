.class public final Lcom/google/firebase/messaging/CommonNotificationBuilder;
.super Ljava/lang/Object;
.source "CommonNotificationBuilder.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/firebase/messaging/CommonNotificationBuilder$DisplayNotificationInfo;
    }
.end annotation


# static fields
.field private static final ACTION_RECEIVER:Ljava/lang/String; = "com.google.android.c2dm.intent.RECEIVE"

.field public static final FCM_FALLBACK_NOTIFICATION_CHANNEL:Ljava/lang/String; = "fcm_fallback_notification_channel"

.field public static final FCM_FALLBACK_NOTIFICATION_CHANNEL_LABEL:Ljava/lang/String; = "fcm_fallback_notification_channel_label"

.field private static final FCM_FALLBACK_NOTIFICATION_CHANNEL_NAME_NO_RESOURCE:Ljava/lang/String; = "Misc"

.field private static final ILLEGAL_RESOURCE_ID:I = 0x0

.field public static final METADATA_DEFAULT_CHANNEL_ID:Ljava/lang/String; = "com.google.firebase.messaging.default_notification_channel_id"

.field public static final METADATA_DEFAULT_COLOR:Ljava/lang/String; = "com.google.firebase.messaging.default_notification_color"

.field public static final METADATA_DEFAULT_ICON:Ljava/lang/String; = "com.google.firebase.messaging.default_notification_icon"

.field private static final requestCodeProvider:Ljava/util/concurrent/atomic/AtomicInteger;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 91
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    .line 92
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    long-to-int v1, v1

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    sput-object v0, Lcom/google/firebase/messaging/CommonNotificationBuilder;->requestCodeProvider:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 91
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 95
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static createContentIntent(Landroid/content/Context;Lcom/google/firebase/messaging/NotificationParams;Ljava/lang/String;Landroid/content/pm/PackageManager;)Landroid/app/PendingIntent;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "params"    # Lcom/google/firebase/messaging/NotificationParams;
    .param p2, "pkgName"    # Ljava/lang/String;
    .param p3, "pm"    # Landroid/content/pm/PackageManager;

    .line 373
    invoke-static {p2, p1, p3}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->createTargetIntent(Ljava/lang/String;Lcom/google/firebase/messaging/NotificationParams;Landroid/content/pm/PackageManager;)Landroid/content/Intent;

    move-result-object v0

    .line 374
    .local v0, "intent":Landroid/content/Intent;
    if-nez v0, :cond_0

    .line 375
    const/4 v1, 0x0

    return-object v1

    .line 381
    :cond_0
    const/high16 v1, 0x4000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 385
    invoke-virtual {p1}, Lcom/google/firebase/messaging/NotificationParams;->paramsWithReservedKeysRemoved()Landroid/os/Bundle;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    .line 387
    invoke-static {p1}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->shouldUploadMetrics(Lcom/google/firebase/messaging/NotificationParams;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 389
    const-string v1, "gcm.n.analytics_data"

    invoke-virtual {p1}, Lcom/google/firebase/messaging/NotificationParams;->paramsForAnalyticsIntent()Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 392
    :cond_1
    nop

    .line 394
    invoke-static {}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->generatePendingIntentRequestCode()I

    move-result v1

    .line 396
    const/high16 v2, 0x40000000    # 2.0f

    invoke-static {v2}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getPendingIntentFlags(I)I

    move-result v2

    .line 392
    invoke-static {p0, v1, v0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    return-object v1
.end method

.method private static createDeleteIntent(Landroid/content/Context;Landroid/content/Context;Lcom/google/firebase/messaging/NotificationParams;)Landroid/app/PendingIntent;
    .locals 2
    .param p0, "callingContext"    # Landroid/content/Context;
    .param p1, "appContext"    # Landroid/content/Context;
    .param p2, "params"    # Lcom/google/firebase/messaging/NotificationParams;

    .line 550
    invoke-static {p2}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->shouldUploadMetrics(Lcom/google/firebase/messaging/NotificationParams;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 551
    const/4 v0, 0x0

    return-object v0

    .line 554
    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.google.firebase.messaging.NOTIFICATION_DISMISS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 556
    invoke-virtual {p2}, Lcom/google/firebase/messaging/NotificationParams;->paramsForAnalyticsIntent()Landroid/os/Bundle;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    move-result-object v0

    .line 558
    .local v0, "dismissIntent":Landroid/content/Intent;
    invoke-static {p0, p1, v0}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->createMessagingPendingIntent(Landroid/content/Context;Landroid/content/Context;Landroid/content/Intent;)Landroid/app/PendingIntent;

    move-result-object v1

    return-object v1
.end method

.method private static createMessagingPendingIntent(Landroid/content/Context;Landroid/content/Context;Landroid/content/Intent;)Landroid/app/PendingIntent;
    .locals 3
    .param p0, "callingContext"    # Landroid/content/Context;
    .param p1, "appContext"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 564
    nop

    .line 566
    invoke-static {}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->generatePendingIntentRequestCode()I

    move-result v0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.google.android.c2dm.intent.RECEIVE"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 568
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    .line 569
    const-string v2, "wrapped_intent"

    invoke-virtual {v1, v2, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object v1

    .line 570
    const/high16 v2, 0x40000000    # 2.0f

    invoke-static {v2}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getPendingIntentFlags(I)I

    move-result v2

    .line 564
    invoke-static {p0, v0, v1, v2}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    return-object v0
.end method

.method public static createNotificationInfo(Landroid/content/Context;Landroid/content/Context;Lcom/google/firebase/messaging/NotificationParams;Ljava/lang/String;Landroid/os/Bundle;)Lcom/google/firebase/messaging/CommonNotificationBuilder$DisplayNotificationInfo;
    .locals 26
    .param p0, "callingContext"    # Landroid/content/Context;
    .param p1, "appContext"    # Landroid/content/Context;
    .param p2, "params"    # Lcom/google/firebase/messaging/NotificationParams;
    .param p3, "channelId"    # Ljava/lang/String;
    .param p4, "manifestMetadata"    # Landroid/os/Bundle;

    .line 122
    move-object/from16 v0, p1

    move-object/from16 v1, p2

    move-object/from16 v2, p4

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 123
    .local v3, "pkgName":Ljava/lang/String;
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    .line 124
    .local v4, "appResources":Landroid/content/res/Resources;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    .line 125
    .local v5, "appPackageManager":Landroid/content/pm/PackageManager;
    new-instance v6, Landroidx/core/app/NotificationCompat$Builder;

    move-object/from16 v7, p3

    invoke-direct {v6, v0, v7}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 127
    .local v6, "builder":Landroidx/core/app/NotificationCompat$Builder;
    nop

    .line 128
    const-string v8, "gcm.n.title"

    invoke-virtual {v1, v4, v3, v8}, Lcom/google/firebase/messaging/NotificationParams;->getPossiblyLocalizedString(Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 130
    .local v8, "title":Ljava/lang/String;
    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_0

    .line 131
    invoke-virtual {v6, v8}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    .line 134
    :cond_0
    nop

    .line 135
    const-string v9, "gcm.n.body"

    invoke-virtual {v1, v4, v3, v9}, Lcom/google/firebase/messaging/NotificationParams;->getPossiblyLocalizedString(Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 137
    .local v9, "body":Ljava/lang/String;
    invoke-static {v9}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-nez v10, :cond_1

    .line 138
    invoke-virtual {v6, v9}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    .line 139
    new-instance v10, Landroidx/core/app/NotificationCompat$BigTextStyle;

    invoke-direct {v10}, Landroidx/core/app/NotificationCompat$BigTextStyle;-><init>()V

    invoke-virtual {v10, v9}, Landroidx/core/app/NotificationCompat$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$BigTextStyle;

    move-result-object v10

    invoke-virtual {v6, v10}, Landroidx/core/app/NotificationCompat$Builder;->setStyle(Landroidx/core/app/NotificationCompat$Style;)Landroidx/core/app/NotificationCompat$Builder;

    .line 142
    :cond_1
    nop

    .line 147
    const-string v10, "gcm.n.icon"

    invoke-virtual {v1, v10}, Lcom/google/firebase/messaging/NotificationParams;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 143
    invoke-static {v5, v4, v3, v10, v2}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getSmallIcon(Landroid/content/pm/PackageManager;Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)I

    move-result v10

    .line 149
    .local v10, "smallIcon":I
    invoke-virtual {v6, v10}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    .line 151
    invoke-static {v3, v1, v4}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getSound(Ljava/lang/String;Lcom/google/firebase/messaging/NotificationParams;Landroid/content/res/Resources;)Landroid/net/Uri;

    move-result-object v11

    .line 152
    .local v11, "sound":Landroid/net/Uri;
    if-eqz v11, :cond_2

    .line 153
    invoke-virtual {v6, v11}, Landroidx/core/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroidx/core/app/NotificationCompat$Builder;

    .line 156
    :cond_2
    nop

    .line 157
    move-object/from16 v12, p0

    invoke-static {v12, v1, v3, v5}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->createContentIntent(Landroid/content/Context;Lcom/google/firebase/messaging/NotificationParams;Ljava/lang/String;Landroid/content/pm/PackageManager;)Landroid/app/PendingIntent;

    move-result-object v13

    .line 156
    invoke-virtual {v6, v13}, Landroidx/core/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Builder;

    .line 159
    invoke-static/range {p0 .. p2}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->createDeleteIntent(Landroid/content/Context;Landroid/content/Context;Lcom/google/firebase/messaging/NotificationParams;)Landroid/app/PendingIntent;

    move-result-object v13

    .line 160
    .local v13, "deleteIntent":Landroid/app/PendingIntent;
    if-eqz v13, :cond_3

    .line 161
    invoke-virtual {v6, v13}, Landroidx/core/app/NotificationCompat$Builder;->setDeleteIntent(Landroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Builder;

    .line 164
    :cond_3
    nop

    .line 165
    const-string v14, "gcm.n.color"

    invoke-virtual {v1, v14}, Lcom/google/firebase/messaging/NotificationParams;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-static {v0, v14, v2}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getColor(Landroid/content/Context;Ljava/lang/String;Landroid/os/Bundle;)Ljava/lang/Integer;

    move-result-object v14

    .line 166
    .local v14, "color":Ljava/lang/Integer;
    if-eqz v14, :cond_4

    .line 167
    invoke-virtual {v14}, Ljava/lang/Integer;->intValue()I

    move-result v15

    invoke-virtual {v6, v15}, Landroidx/core/app/NotificationCompat$Builder;->setColor(I)Landroidx/core/app/NotificationCompat$Builder;

    .line 172
    :cond_4
    const-string v15, "gcm.n.sticky"

    invoke-virtual {v1, v15}, Lcom/google/firebase/messaging/NotificationParams;->getBoolean(Ljava/lang/String;)Z

    move-result v15

    .line 173
    .local v15, "sticky":Z
    xor-int/lit8 v0, v15, 0x1

    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroidx/core/app/NotificationCompat$Builder;

    .line 175
    const-string v0, "gcm.n.local_only"

    invoke-virtual {v1, v0}, Lcom/google/firebase/messaging/NotificationParams;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    .line 176
    .local v0, "localOnly":Z
    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setLocalOnly(Z)Landroidx/core/app/NotificationCompat$Builder;

    .line 178
    move/from16 v16, v0

    .end local v0    # "localOnly":Z
    .local v16, "localOnly":Z
    const-string v0, "gcm.n.ticker"

    invoke-virtual {v1, v0}, Lcom/google/firebase/messaging/NotificationParams;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 179
    .local v0, "ticker":Ljava/lang/String;
    if-eqz v0, :cond_5

    .line 180
    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    .line 183
    :cond_5
    invoke-virtual {v1}, Lcom/google/firebase/messaging/NotificationParams;->getNotificationPriority()Ljava/lang/Integer;

    move-result-object v17

    .line 184
    .local v17, "notificationPriority":Ljava/lang/Integer;
    if-eqz v17, :cond_6

    .line 185
    move-object/from16 v18, v0

    .end local v0    # "ticker":Ljava/lang/String;
    .local v18, "ticker":Ljava/lang/String;
    invoke-virtual/range {v17 .. v17}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setPriority(I)Landroidx/core/app/NotificationCompat$Builder;

    goto :goto_0

    .line 184
    .end local v18    # "ticker":Ljava/lang/String;
    .restart local v0    # "ticker":Ljava/lang/String;
    :cond_6
    move-object/from16 v18, v0

    .line 188
    .end local v0    # "ticker":Ljava/lang/String;
    .restart local v18    # "ticker":Ljava/lang/String;
    :goto_0
    invoke-virtual {v1}, Lcom/google/firebase/messaging/NotificationParams;->getVisibility()Ljava/lang/Integer;

    move-result-object v0

    .line 189
    .local v0, "visibility":Ljava/lang/Integer;
    if-eqz v0, :cond_7

    .line 190
    move-object/from16 v19, v0

    .end local v0    # "visibility":Ljava/lang/Integer;
    .local v19, "visibility":Ljava/lang/Integer;
    invoke-virtual/range {v19 .. v19}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setVisibility(I)Landroidx/core/app/NotificationCompat$Builder;

    goto :goto_1

    .line 189
    .end local v19    # "visibility":Ljava/lang/Integer;
    .restart local v0    # "visibility":Ljava/lang/Integer;
    :cond_7
    move-object/from16 v19, v0

    .line 193
    .end local v0    # "visibility":Ljava/lang/Integer;
    .restart local v19    # "visibility":Ljava/lang/Integer;
    :goto_1
    invoke-virtual {v1}, Lcom/google/firebase/messaging/NotificationParams;->getNotificationCount()Ljava/lang/Integer;

    move-result-object v0

    .line 194
    .local v0, "notificationCount":Ljava/lang/Integer;
    if-eqz v0, :cond_8

    .line 195
    move-object/from16 v20, v0

    .end local v0    # "notificationCount":Ljava/lang/Integer;
    .local v20, "notificationCount":Ljava/lang/Integer;
    invoke-virtual/range {v20 .. v20}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setNumber(I)Landroidx/core/app/NotificationCompat$Builder;

    goto :goto_2

    .line 194
    .end local v20    # "notificationCount":Ljava/lang/Integer;
    .restart local v0    # "notificationCount":Ljava/lang/Integer;
    :cond_8
    move-object/from16 v20, v0

    .line 198
    .end local v0    # "notificationCount":Ljava/lang/Integer;
    .restart local v20    # "notificationCount":Ljava/lang/Integer;
    :goto_2
    const-string v0, "gcm.n.event_time"

    invoke-virtual {v1, v0}, Lcom/google/firebase/messaging/NotificationParams;->getLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    .line 199
    .local v0, "eventTime":Ljava/lang/Long;
    move-object/from16 v21, v0

    .end local v0    # "eventTime":Ljava/lang/Long;
    .local v21, "eventTime":Ljava/lang/Long;
    const/4 v0, 0x1

    if-eqz v21, :cond_9

    .line 202
    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setShowWhen(Z)Landroidx/core/app/NotificationCompat$Builder;

    .line 203
    move/from16 v22, v0

    invoke-virtual/range {v21 .. v21}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {v6, v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setWhen(J)Landroidx/core/app/NotificationCompat$Builder;

    goto :goto_3

    .line 199
    :cond_9
    move/from16 v22, v0

    .line 206
    :goto_3
    invoke-virtual/range {p2 .. p2}, Lcom/google/firebase/messaging/NotificationParams;->getVibrateTimings()[J

    move-result-object v0

    .line 207
    .local v0, "vibrateTimings":[J
    if-eqz v0, :cond_a

    .line 208
    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setVibrate([J)Landroidx/core/app/NotificationCompat$Builder;

    .line 212
    :cond_a
    invoke-virtual/range {p2 .. p2}, Lcom/google/firebase/messaging/NotificationParams;->getLightSettings()[I

    move-result-object v1

    .line 213
    .local v1, "lightSettings":[I
    move-object/from16 v23, v0

    .end local v0    # "vibrateTimings":[J
    .local v23, "vibrateTimings":[J
    if-eqz v1, :cond_b

    .line 214
    const/16 v24, 0x0

    aget v0, v1, v24

    move-object/from16 v25, v1

    .end local v1    # "lightSettings":[I
    .local v25, "lightSettings":[I
    aget v1, v25, v22

    const/16 v22, 0x2

    aget v2, v25, v22

    invoke-virtual {v6, v0, v1, v2}, Landroidx/core/app/NotificationCompat$Builder;->setLights(III)Landroidx/core/app/NotificationCompat$Builder;

    goto :goto_4

    .line 213
    .end local v25    # "lightSettings":[I
    .restart local v1    # "lightSettings":[I
    :cond_b
    move-object/from16 v25, v1

    const/16 v24, 0x0

    .line 220
    .end local v1    # "lightSettings":[I
    .restart local v25    # "lightSettings":[I
    :goto_4
    invoke-static/range {p2 .. p2}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getConsolidatedDefaults(Lcom/google/firebase/messaging/NotificationParams;)I

    move-result v0

    invoke-virtual {v6, v0}, Landroidx/core/app/NotificationCompat$Builder;->setDefaults(I)Landroidx/core/app/NotificationCompat$Builder;

    .line 222
    new-instance v0, Lcom/google/firebase/messaging/CommonNotificationBuilder$DisplayNotificationInfo;

    invoke-static/range {p2 .. p2}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getTag(Lcom/google/firebase/messaging/NotificationParams;)Ljava/lang/String;

    move-result-object v1

    move/from16 v2, v24

    invoke-direct {v0, v6, v1, v2}, Lcom/google/firebase/messaging/CommonNotificationBuilder$DisplayNotificationInfo;-><init>(Landroidx/core/app/NotificationCompat$Builder;Ljava/lang/String;I)V

    return-object v0
.end method

.method static createNotificationInfo(Landroid/content/Context;Lcom/google/firebase/messaging/NotificationParams;)Lcom/google/firebase/messaging/CommonNotificationBuilder$DisplayNotificationInfo;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "params"    # Lcom/google/firebase/messaging/NotificationParams;

    .line 100
    nop

    .line 101
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getManifestMetadata(Landroid/content/pm/PackageManager;Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    .line 103
    .local v0, "manifestMetadata":Landroid/os/Bundle;
    nop

    .line 107
    invoke-virtual {p1}, Lcom/google/firebase/messaging/NotificationParams;->getNotificationChannelId()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1, v0}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->getOrCreateChannel(Landroid/content/Context;Ljava/lang/String;Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v1

    .line 103
    invoke-static {p0, p0, p1, v1, v0}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->createNotificationInfo(Landroid/content/Context;Landroid/content/Context;Lcom/google/firebase/messaging/NotificationParams;Ljava/lang/String;Landroid/os/Bundle;)Lcom/google/firebase/messaging/CommonNotificationBuilder$DisplayNotificationInfo;

    move-result-object v1

    return-object v1
.end method

.method private static createTargetIntent(Ljava/lang/String;Lcom/google/firebase/messaging/NotificationParams;Landroid/content/pm/PackageManager;)Landroid/content/Intent;
    .locals 5
    .param p0, "pkgName"    # Ljava/lang/String;
    .param p1, "params"    # Lcom/google/firebase/messaging/NotificationParams;
    .param p2, "pm"    # Landroid/content/pm/PackageManager;

    .line 401
    const-string v0, "gcm.n.click_action"

    invoke-virtual {p1, v0}, Lcom/google/firebase/messaging/NotificationParams;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 402
    .local v0, "action":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 404
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 405
    .local v1, "intent":Landroid/content/Intent;
    invoke-virtual {v1, p0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 406
    const/high16 v2, 0x10000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 407
    return-object v1

    .line 410
    .end local v1    # "intent":Landroid/content/Intent;
    :cond_0
    invoke-virtual {p1}, Lcom/google/firebase/messaging/NotificationParams;->getLink()Landroid/net/Uri;

    move-result-object v1

    .line 411
    .local v1, "link":Landroid/net/Uri;
    if-eqz v1, :cond_1

    .line 412
    new-instance v2, Landroid/content/Intent;

    const-string v3, "android.intent.action.VIEW"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 413
    .local v2, "intent":Landroid/content/Intent;
    invoke-virtual {v2, p0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 414
    invoke-virtual {v2, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 415
    return-object v2

    .line 419
    .end local v2    # "intent":Landroid/content/Intent;
    :cond_1
    invoke-virtual {p2, p0}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v2

    .line 420
    .restart local v2    # "intent":Landroid/content/Intent;
    if-nez v2, :cond_2

    .line 421
    const-string v3, "FirebaseMessaging"

    const-string v4, "No activity found to launch app"

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 423
    :cond_2
    return-object v2
.end method

.method private static generatePendingIntentRequestCode()I
    .locals 1

    .line 533
    sget-object v0, Lcom/google/firebase/messaging/CommonNotificationBuilder;->requestCodeProvider:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v0

    return v0
.end method

.method private static getColor(Landroid/content/Context;Ljava/lang/String;Landroid/os/Bundle;)Ljava/lang/Integer;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "color"    # Ljava/lang/String;
    .param p2, "manifestMetadata"    # Landroid/os/Bundle;

    .line 320
    nop

    .line 324
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const-string v1, "FirebaseMessaging"

    if-nez v0, :cond_0

    .line 326
    :try_start_0
    invoke-static {p1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 327
    :catch_0
    move-exception v0

    .line 328
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Color is invalid: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ". Notification will use default color."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 332
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :cond_0
    const-string v0, "com.google.firebase.messaging.default_notification_color"

    const/4 v2, 0x0

    invoke-virtual {p2, v0, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 333
    .local v0, "colorResourceId":I
    if-eqz v0, :cond_1

    .line 335
    :try_start_1
    invoke-static {p0, v0}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1
    :try_end_1
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    return-object v1

    .line 336
    :catch_1
    move-exception v2

    .line 337
    .local v2, "e":Landroid/content/res/Resources$NotFoundException;
    const-string v3, "Cannot find the color resource referenced in AndroidManifest."

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 342
    .end local v2    # "e":Landroid/content/res/Resources$NotFoundException;
    :cond_1
    const/4 v1, 0x0

    return-object v1
.end method

.method private static getConsolidatedDefaults(Lcom/google/firebase/messaging/NotificationParams;)I
    .locals 2
    .param p0, "params"    # Lcom/google/firebase/messaging/NotificationParams;

    .line 226
    const/4 v0, 0x0

    .line 228
    .local v0, "result":I
    const-string v1, "gcm.n.default_sound"

    invoke-virtual {p0, v1}, Lcom/google/firebase/messaging/NotificationParams;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 229
    or-int/lit8 v0, v0, 0x1

    .line 232
    :cond_0
    const-string v1, "gcm.n.default_vibrate_timings"

    invoke-virtual {p0, v1}, Lcom/google/firebase/messaging/NotificationParams;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 233
    or-int/lit8 v0, v0, 0x2

    .line 236
    :cond_1
    const-string v1, "gcm.n.default_light_settings"

    invoke-virtual {p0, v1}, Lcom/google/firebase/messaging/NotificationParams;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 237
    or-int/lit8 v0, v0, 0x4

    .line 240
    :cond_2
    return v0
.end method

.method private static getManifestMetadata(Landroid/content/pm/PackageManager;Ljava/lang/String;)Landroid/os/Bundle;
    .locals 3
    .param p0, "pm"    # Landroid/content/pm/PackageManager;
    .param p1, "packageName"    # Ljava/lang/String;

    .line 428
    const/16 v0, 0x80

    :try_start_0
    invoke-virtual {p0, p1, v0}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 429
    .local v0, "info":Landroid/content/pm/ApplicationInfo;
    if-eqz v0, :cond_0

    iget-object v1, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    if-eqz v1, :cond_0

    .line 430
    iget-object v1, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 434
    .end local v0    # "info":Landroid/content/pm/ApplicationInfo;
    :cond_0
    goto :goto_0

    .line 432
    :catch_0
    move-exception v0

    .line 433
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Couldn\'t get own application info: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "FirebaseMessaging"

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 436
    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :goto_0
    sget-object v0, Landroid/os/Bundle;->EMPTY:Landroid/os/Bundle;

    return-object v0
.end method

.method public static getOrCreateChannel(Landroid/content/Context;Ljava/lang/String;Landroid/os/Bundle;)Ljava/lang/String;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "msgChannel"    # Ljava/lang/String;
    .param p2, "manifestMetadata"    # Landroid/os/Bundle;

    .line 443
    nop

    .line 450
    nop

    .line 451
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 452
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->targetSdkVersion:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v2, 0x1a

    if-ge v1, v2, :cond_0

    .line 455
    return-object v0

    .line 460
    :cond_0
    nop

    .line 462
    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 464
    .local v0, "notificationManager":Landroid/app/NotificationManager;
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const-string v2, "FirebaseMessaging"

    if-nez v1, :cond_2

    .line 465
    invoke-virtual {v0, p1}, Landroid/app/NotificationManager;->getNotificationChannel(Ljava/lang/String;)Landroid/app/NotificationChannel;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 466
    return-object p1

    .line 468
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Notification Channel requested ("

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ") has not been created by the app. Manifest configuration, or default, value will be used."

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 477
    :cond_2
    const-string v1, "com.google.firebase.messaging.default_notification_channel_id"

    invoke-virtual {p2, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 478
    .local v1, "manifestChannel":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 479
    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->getNotificationChannel(Ljava/lang/String;)Landroid/app/NotificationChannel;

    move-result-object v3

    if-eqz v3, :cond_3

    .line 480
    return-object v1

    .line 482
    :cond_3
    const-string v3, "Notification Channel set in AndroidManifest.xml has not been created by the app. Default value will be used."

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 488
    :cond_4
    const-string v3, "Missing Default Notification Channel metadata in AndroidManifest. Default value will be used."

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 495
    :goto_0
    const-string v3, "fcm_fallback_notification_channel"

    invoke-virtual {v0, v3}, Landroid/app/NotificationManager;->getNotificationChannel(Ljava/lang/String;)Landroid/app/NotificationChannel;

    move-result-object v4

    if-nez v4, :cond_6

    .line 496
    nop

    .line 498
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    .line 500
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    .line 499
    const-string v6, "fcm_fallback_notification_channel_label"

    const-string v7, "string"

    invoke-virtual {v4, v6, v7, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 503
    .local v4, "channelLabelResourceId":I
    if-nez v4, :cond_5

    .line 504
    const-string v5, "String resource \"fcm_fallback_notification_channel_label\" is not found. Using default string channel name."

    invoke-static {v2, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 509
    const-string v2, "Misc"

    .local v2, "defaultChannelName":Ljava/lang/String;
    goto :goto_1

    .line 511
    .end local v2    # "defaultChannelName":Ljava/lang/String;
    :cond_5
    invoke-virtual {p0, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 514
    .restart local v2    # "defaultChannelName":Ljava/lang/String;
    :goto_1
    new-instance v5, Landroid/app/NotificationChannel;

    const/4 v6, 0x3

    invoke-direct {v5, v3, v2, v6}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    invoke-virtual {v0, v5}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 524
    .end local v2    # "defaultChannelName":Ljava/lang/String;
    .end local v4    # "channelLabelResourceId":I
    :cond_6
    return-object v3

    .line 457
    .end local v0    # "notificationManager":Landroid/app/NotificationManager;
    .end local v1    # "manifestChannel":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 459
    .local v1, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    return-object v0
.end method

.method private static getPendingIntentFlags(I)I
    .locals 1
    .param p0, "baseFlags"    # I

    .line 542
    nop

    .line 543
    const/high16 v0, 0x4000000

    or-int/2addr v0, p0

    .line 542
    return v0
.end method

.method private static getSmallIcon(Landroid/content/pm/PackageManager;Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)I
    .locals 5
    .param p0, "packageManager"    # Landroid/content/pm/PackageManager;
    .param p1, "resources"    # Landroid/content/res/Resources;
    .param p2, "pkgName"    # Ljava/lang/String;
    .param p3, "resourceKey"    # Ljava/lang/String;
    .param p4, "manifestMetadata"    # Landroid/os/Bundle;

    .line 279
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const-string v1, "FirebaseMessaging"

    if-nez v0, :cond_2

    .line 282
    const-string v0, "drawable"

    invoke-virtual {p1, p3, v0, p2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 284
    .local v0, "iconId":I
    if-eqz v0, :cond_0

    invoke-static {p1, v0}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->isValidIcon(Landroid/content/res/Resources;I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 285
    return v0

    .line 289
    :cond_0
    const-string v2, "mipmap"

    invoke-virtual {p1, p3, v2, p2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 291
    if-eqz v0, :cond_1

    invoke-static {p1, v0}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->isValidIcon(Landroid/content/res/Resources;I)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 292
    return v0

    .line 295
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Icon resource "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " not found. Notification will use default icon."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 299
    .end local v0    # "iconId":I
    :cond_2
    const-string v0, "com.google.firebase.messaging.default_notification_icon"

    const/4 v2, 0x0

    invoke-virtual {p4, v0, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 301
    .restart local v0    # "iconId":I
    if-eqz v0, :cond_3

    invoke-static {p1, v0}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->isValidIcon(Landroid/content/res/Resources;I)Z

    move-result v3

    if-nez v3, :cond_4

    .line 304
    :cond_3
    :try_start_0
    invoke-virtual {p0, p2, v2}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v2

    iget v1, v2, Landroid/content/pm/ApplicationInfo;->icon:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move v0, v1

    .line 307
    goto :goto_0

    .line 305
    :catch_0
    move-exception v2

    .line 306
    .local v2, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Couldn\'t get own application info: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 310
    .end local v2    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :cond_4
    :goto_0
    if-eqz v0, :cond_5

    invoke-static {p1, v0}, Lcom/google/firebase/messaging/CommonNotificationBuilder;->isValidIcon(Landroid/content/res/Resources;I)Z

    move-result v1

    if-nez v1, :cond_6

    .line 312
    :cond_5
    const v0, 0x1080093

    .line 315
    :cond_6
    return v0
.end method

.method private static getSound(Ljava/lang/String;Lcom/google/firebase/messaging/NotificationParams;Landroid/content/res/Resources;)Landroid/net/Uri;
    .locals 4
    .param p0, "pkgName"    # Ljava/lang/String;
    .param p1, "params"    # Lcom/google/firebase/messaging/NotificationParams;
    .param p2, "resources"    # Landroid/content/res/Resources;

    .line 346
    invoke-virtual {p1}, Lcom/google/firebase/messaging/NotificationParams;->getSoundResourceName()Ljava/lang/String;

    move-result-object v0

    .line 347
    .local v0, "soundName":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 348
    const/4 v1, 0x0

    return-object v1

    .line 355
    :cond_0
    const-string v1, "default"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 357
    const-string v1, "raw"

    invoke-virtual {p2, v0, v1, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 358
    .local v1, "soundId":I
    if-eqz v1, :cond_1

    .line 359
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "android.resource://"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/raw/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    return-object v2

    .line 365
    .end local v1    # "soundId":I
    :cond_1
    const/4 v1, 0x2

    invoke-static {v1}, Landroid/media/RingtoneManager;->getDefaultUri(I)Landroid/net/Uri;

    move-result-object v1

    return-object v1
.end method

.method private static getTag(Lcom/google/firebase/messaging/NotificationParams;)Ljava/lang/String;
    .locals 4
    .param p0, "params"    # Lcom/google/firebase/messaging/NotificationParams;

    .line 579
    const-string v0, "gcm.n.tag"

    invoke-virtual {p0, v0}, Lcom/google/firebase/messaging/NotificationParams;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 580
    .local v0, "tag":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 581
    return-object v0

    .line 586
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "FCM-Notification:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private static isValidIcon(Landroid/content/res/Resources;I)Z
    .locals 5
    .param p0, "resources"    # Landroid/content/res/Resources;
    .param p1, "resId"    # I

    .line 251
    const-string v0, "FirebaseMessaging"

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    const/4 v3, 0x1

    if-eq v1, v2, :cond_0

    .line 252
    return v3

    .line 256
    :cond_0
    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {p0, p1, v1}, Landroid/content/res/Resources;->getDrawable(ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 257
    .local v1, "icon":Landroid/graphics/drawable/Drawable;
    instance-of v4, v1, Landroid/graphics/drawable/AdaptiveIconDrawable;

    if-eqz v4, :cond_1

    .line 262
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Adaptive icons cannot be used in notifications. Ignoring icon id: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 263
    return v2

    .line 265
    :cond_1
    return v3

    .line 267
    .end local v1    # "icon":Landroid/graphics/drawable/Drawable;
    :catch_0
    move-exception v1

    .line 268
    .local v1, "ex":Landroid/content/res/Resources$NotFoundException;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Couldn\'t find resource "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", treating it as an invalid icon"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 269
    return v2
.end method

.method static shouldUploadMetrics(Lcom/google/firebase/messaging/NotificationParams;)Z
    .locals 1
    .param p0, "params"    # Lcom/google/firebase/messaging/NotificationParams;

    .line 575
    const-string v0, "google.c.a.e"

    invoke-virtual {p0, v0}, Lcom/google/firebase/messaging/NotificationParams;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method
