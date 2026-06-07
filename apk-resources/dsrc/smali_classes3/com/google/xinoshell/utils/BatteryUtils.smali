.class public Lcom/google/xinoshell/utils/BatteryUtils;
.super Ljava/lang/Object;
.source "BatteryUtils.java"


# static fields
.field static final synthetic $assertionsDisabled:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 8
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getBatteryPercentage(Landroid/content/Context;)Ljava/lang/String;
    .locals 7
    .param p0, "context"    # Landroid/content/Context;

    .line 11
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.intent.action.BATTERY_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 12
    .local v0, "ifilter":Landroid/content/IntentFilter;
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    move-result-object v1

    .line 14
    .local v1, "batteryStatus":Landroid/content/Intent;
    if-eqz v1, :cond_2

    .line 15
    const-string v2, "level"

    const/4 v3, -0x1

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    .line 16
    .local v2, "level":I
    const-string v4, "scale"

    invoke-virtual {v1, v4, v3}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v4

    .line 18
    .local v4, "scale":I
    if-eq v2, v3, :cond_1

    if-ne v4, v3, :cond_0

    goto :goto_0

    .line 22
    :cond_0
    int-to-float v3, v2

    int-to-float v5, v4

    div-float/2addr v3, v5

    const/high16 v5, 0x42c80000    # 100.0f

    mul-float/2addr v3, v5

    float-to-int v3, v3

    .line 23
    .local v3, "batteryPercentage":I
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "%"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    return-object v5

    .line 19
    .end local v3    # "batteryPercentage":I
    :cond_1
    :goto_0
    const-string v3, "Unknown"

    return-object v3

    .line 14
    .end local v2    # "level":I
    .end local v4    # "scale":I
    :cond_2
    new-instance v2, Ljava/lang/AssertionError;

    invoke-direct {v2}, Ljava/lang/AssertionError;-><init>()V

    throw v2
.end method
