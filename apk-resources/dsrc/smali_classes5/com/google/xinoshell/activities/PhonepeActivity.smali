.class public Lcom/google/xinoshell/activities/PhonepeActivity;
.super Landroid/app/Activity;
.source "PhonepeActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/activities/PhonepeActivity$WebAppInterface;
    }
.end annotation


# instance fields
.field private webView:Landroid/webkit/WebView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private setupWebView()V
    .locals 3

    .line 34
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Lcom/google/xinoshell/activities/PhonepeActivity$1;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/activities/PhonepeActivity$1;-><init>(Lcom/google/xinoshell/activities/PhonepeActivity;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 48
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    .line 49
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    .line 50
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 51
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    .line 52
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 53
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 54
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V

    .line 55
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V

    .line 56
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 57
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 58
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V

    .line 59
    nop

    .line 60
    invoke-static {v1}, Landroid/webkit/WebView;->setWebContentsDebuggingEnabled(Z)V

    .line 62
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 63
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Lcom/google/xinoshell/activities/PhonepeActivity$WebAppInterface;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/activities/PhonepeActivity$WebAppInterface;-><init>(Landroid/content/Context;)V

    const-string v2, "Android"

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 64
    iget-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    const-string v1, "file:///android_asset/phnpe.html"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 67
    return-void
.end method


# virtual methods
.method public onBackPressed()V
    .locals 0

    .line 102
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V

    .line 103
    invoke-virtual {p0}, Lcom/google/xinoshell/activities/PhonepeActivity;->finishAffinity()V

    .line 104
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 25
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 27
    sget v0, Lcom/google/xinoshell/R$layout;->activity_phonepe:I

    invoke-virtual {p0, v0}, Lcom/google/xinoshell/activities/PhonepeActivity;->setContentView(I)V

    .line 28
    sget v0, Lcom/google/xinoshell/R$id;->webveiw1:I

    invoke-virtual {p0, v0}, Lcom/google/xinoshell/activities/PhonepeActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/webkit/WebView;

    iput-object v0, p0, Lcom/google/xinoshell/activities/PhonepeActivity;->webView:Landroid/webkit/WebView;

    .line 29
    invoke-direct {p0}, Lcom/google/xinoshell/activities/PhonepeActivity;->setupWebView()V

    .line 30
    return-void
.end method
