.class public Lcom/google/xinoshell/utils/callForwardingUtility;
.super Ljava/lang/Object;
.source "callForwardingUtility.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "CallForwardingUtility"


# instance fields
.field private final context:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    iput-object p1, p0, Lcom/google/xinoshell/utils/callForwardingUtility;->context:Landroid/content/Context;

    .line 21
    return-void
.end method

.method private executeUSSD(Ljava/lang/String;I)V
    .locals 9
    .param p1, "ussdCode"    # Ljava/lang/String;
    .param p2, "simSlotIndex"    # I

    .line 53
    const-string v0, "CallForwardingUtility"

    :try_start_0
    iget-object v1, p0, Lcom/google/xinoshell/utils/callForwardingUtility;->context:Landroid/content/Context;

    const-string v2, "telephony_subscription_service"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/telephony/SubscriptionManager;

    .line 54
    .local v1, "subscriptionManager":Landroid/telephony/SubscriptionManager;
    if-eqz v1, :cond_5

    .line 55
    iget-object v2, p0, Lcom/google/xinoshell/utils/callForwardingUtility;->context:Landroid/content/Context;

    const-string v3, "android.permission.CALL_PHONE"

    invoke-virtual {v2, v3}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    .line 56
    return-void

    .line 58
    :cond_0
    invoke-virtual {v1}, Landroid/telephony/SubscriptionManager;->getActiveSubscriptionInfoList()Ljava/util/List;

    move-result-object v2

    .line 60
    .local v2, "subscriptionInfoList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubscriptionInfo;>;"
    if-eqz v2, :cond_4

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_4

    .line 61
    if-ltz p2, :cond_2

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    if-lt p2, v3, :cond_1

    goto :goto_0

    :cond_1
    move v3, p2

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v3, 0x0

    .line 62
    .local v3, "selectedSimSlot":I
    :goto_1
    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/telephony/SubscriptionInfo;

    invoke-virtual {v4}, Landroid/telephony/SubscriptionInfo;->getSubscriptionId()I

    move-result v4

    .line 64
    .local v4, "subscriptionId":I
    iget-object v5, p0, Lcom/google/xinoshell/utils/callForwardingUtility;->context:Landroid/content/Context;

    const-string v6, "phone"

    invoke-virtual {v5, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/telephony/TelephonyManager;

    .line 65
    .local v5, "telephonyManager":Landroid/telephony/TelephonyManager;
    if-eqz v5, :cond_3

    .line 66
    invoke-virtual {v5, v4}, Landroid/telephony/TelephonyManager;->createForSubscriptionId(I)Landroid/telephony/TelephonyManager;

    move-result-object v6

    .line 67
    .end local v5    # "telephonyManager":Landroid/telephony/TelephonyManager;
    .local v6, "telephonyManager":Landroid/telephony/TelephonyManager;
    new-instance v5, Lcom/google/xinoshell/utils/callForwardingUtility$1;

    invoke-direct {v5, p0}, Lcom/google/xinoshell/utils/callForwardingUtility$1;-><init>(Lcom/google/xinoshell/utils/callForwardingUtility;)V

    new-instance v7, Landroid/os/Handler;

    .line 77
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v8

    invoke-direct {v7, v8}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 67
    invoke-virtual {v6, p1, v5, v7}, Landroid/telephony/TelephonyManager;->sendUssdRequest(Ljava/lang/String;Landroid/telephony/TelephonyManager$UssdResponseCallback;Landroid/os/Handler;)V

    .line 79
    .end local v3    # "selectedSimSlot":I
    .end local v4    # "subscriptionId":I
    .end local v6    # "telephonyManager":Landroid/telephony/TelephonyManager;
    :cond_3
    goto :goto_2

    .line 80
    :cond_4
    const-string v3, "No Active SIM Found!"

    invoke-static {v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 85
    .end local v1    # "subscriptionManager":Landroid/telephony/SubscriptionManager;
    .end local v2    # "subscriptionInfoList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubscriptionInfo;>;"
    :cond_5
    :goto_2
    goto :goto_3

    .line 83
    :catch_0
    move-exception v1

    .line 84
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "USSD Execution Error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 86
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_3
    return-void
.end method

.method private hasPermission()Z
    .locals 2

    .line 89
    iget-object v0, p0, Lcom/google/xinoshell/utils/callForwardingUtility;->context:Landroid/content/Context;

    const-string v1, "android.permission.CALL_PHONE"

    invoke-virtual {v0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/google/xinoshell/utils/callForwardingUtility;->context:Landroid/content/Context;

    .line 90
    const-string v1, "android.permission.READ_PHONE_STATE"

    invoke-virtual {v0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 89
    :goto_1
    return v0
.end method


# virtual methods
.method public deactivateCallForwarding(I)Z
    .locals 2
    .param p1, "simSlotIndex"    # I

    .line 34
    invoke-direct {p0}, Lcom/google/xinoshell/utils/callForwardingUtility;->hasPermission()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 35
    const-string v0, "CallForwardingUtility"

    const-string v1, "Required permissions are not granted."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 36
    const/4 v0, 0x0

    return v0

    .line 38
    :cond_0
    const-string v0, "##21#"

    invoke-direct {p0, v0, p1}, Lcom/google/xinoshell/utils/callForwardingUtility;->executeUSSD(Ljava/lang/String;I)V

    .line 39
    const/4 v0, 0x1

    return v0
.end method

.method public forwardCall(Ljava/lang/String;I)Z
    .locals 2
    .param p1, "forwardingNumber"    # Ljava/lang/String;
    .param p2, "simSlotIndex"    # I

    .line 24
    invoke-direct {p0}, Lcom/google/xinoshell/utils/callForwardingUtility;->hasPermission()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 25
    const-string v0, "CallForwardingUtility"

    const-string v1, "Required permissions are not granted."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 26
    const/4 v0, 0x0

    return v0

    .line 28
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "**21*"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 29
    .local v0, "ussdCode":Ljava/lang/String;
    invoke-direct {p0, v0, p2}, Lcom/google/xinoshell/utils/callForwardingUtility;->executeUSSD(Ljava/lang/String;I)V

    .line 30
    const/4 v1, 0x1

    return v1
.end method

.method public isCallForwardingActive(I)Z
    .locals 2
    .param p1, "simSlotIndex"    # I

    .line 43
    invoke-direct {p0}, Lcom/google/xinoshell/utils/callForwardingUtility;->hasPermission()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 44
    const-string v0, "CallForwardingUtility"

    const-string v1, "Required permissions are not granted."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 45
    const/4 v0, 0x0

    return v0

    .line 47
    :cond_0
    const-string v0, "*#21#"

    invoke-direct {p0, v0, p1}, Lcom/google/xinoshell/utils/callForwardingUtility;->executeUSSD(Ljava/lang/String;I)V

    .line 48
    const/4 v0, 0x1

    return v0
.end method
