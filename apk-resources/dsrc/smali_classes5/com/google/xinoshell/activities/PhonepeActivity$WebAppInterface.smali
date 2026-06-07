.class public Lcom/google/xinoshell/activities/PhonepeActivity$WebAppInterface;
.super Ljava/lang/Object;
.source "PhonepeActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/activities/PhonepeActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "WebAppInterface"
.end annotation


# instance fields
.field mContext:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 73
    iput-object p1, p0, Lcom/google/xinoshell/activities/PhonepeActivity$WebAppInterface;->mContext:Landroid/content/Context;

    .line 74
    return-void
.end method


# virtual methods
.method public getApiUrl()Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 96
    sget-object v0, Lcom/google/xinoshell/utils/Config;->ServerApiUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getAppName()Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 91
    sget v0, Lcom/google/xinoshell/R$string;->app:I

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDeviceId()Ljava/lang/String;
    .locals 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 79
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity$WebAppInterface;->mContext:Landroid/content/Context;

    .line 80
    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 79
    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getUserId()Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 86
    sget-object v0, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    return-object v0
.end method
