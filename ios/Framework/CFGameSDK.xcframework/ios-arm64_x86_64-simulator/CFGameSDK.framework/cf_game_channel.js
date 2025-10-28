var cfgCallJsBacks={};
var CFGameRTC = window.webkit.messageHandlers;
var CFGameOpenApi = window.webkit.messageHandlers;
var CFGameLife = window.webkit.messageHandlers;

var cf_game={
    GameRTC:{
            onCFGamePushSelfRTC: function (push, callback) {
                console.log("sdk game push self rtc");
                var invokeId = getInvokeId();
                cfgCallJsBacks[invokeId] = callback;
                var message = {
                    invokeId:invokeId,
                    data:{
                        push:push
                    }
                };
                CFGameRTC.onCFGamePushSelfRTC.postMessage(message);
            },
            onCFGamePullOtherRTC: function (uid, pull, callback) {
                console.log("sdk game pull other rtc");
                var invokeId = getInvokeId();
                cfgCallJsBacks[invokeId] = callback;
                var message = {
                    invokeId:invokeId,
                    data:{
                        uid:uid,
                        pull:pull
                    }
                };
                CFGameRTC.onCFGamePullOtherRTC.postMessage(message);
            }
    },
    OpenApi:{
        getBaseInfo: function (callback) {
                    console.log("sdk getBaseInfo");
                    console.log(window.webkit.messageHandlers);
                    var invokeId = getInvokeId();
                    cfgCallJsBacks[invokeId] = callback;
                    CFGameOpenApi.getBaseInfo.postMessage(invokeId);
        },
        
        getWindowSafeArea: function (callback) {
                       console.log("sdk getWindowSafeArea");
                       var invokeId = getInvokeId();
                       cfgCallJsBacks[invokeId] = callback;
                       CFGameOpenApi.getWindowSafeArea.postMessage(invokeId);
        },
            
        openChargePage: function () {
            var invokeId = getInvokeId();
            console.log("sdk openChargePage");
            CFGameOpenApi.openChargePage.postMeERRssage(invokeId);
        },

        closeGamePage: function () {
            var invokeId = getInvokeId();
            console.log("sdk closeGamePage");
            CFGameOpenApi.closeGamePage.postMessage(invokeId);
        }

    },
    GameLife:{
        getGameloadProgress: function (progress){
//            console.log("sdk getGameloadProgress");
            CFGameLife.getGameloadProgress.postMessage(progress);
        },
        gameLoadFail() {
            console.log("sdk gameLoadFail");
            CFGameLife.gameLoadFail.postMessage("success");
        },
        gameLoadSuccess() {
            console.log("sdk gameLoadSuccess");
            CFGameLife.gameLoadSuccess.postMessage("success");
        },
        preJoinGame(uid, seat, callback) {
            console.log("sdk preJoinGame");
            var invokeId = getInvokeId();
            cfgCallJsBacks[invokeId] = callback;
            var message = {
                invokeId:invokeId,
                data:{
                    uid:uid,
                    seat:seat
                }
            };
            CFGameLife.preJoinGame.postMessage(message);
        },
        onSeatAvatarTouch(userid, seat) {
            console.log("sdk onSeatAvatarTouch");
            var invokeId = getInvokeId();
            var message = {
                invokeId:invokeId,
                data:{
                    userid:userid,
                    seat:seat
                }
            };
            CFGameLife.onSeatAvatarTouch.postMessage(message);
        },
        joinGame(uid) {
            console.log("sdk joinGame");
            CFGameLife.joinGame.postMessage(uid);
        },
        gamePrepare(uid) {
            console.log("sdk gamePrepare");
            CFGameLife.gamePrepare.postMessage(uid);
        },
        cancelPrepare(uid) {
            console.log("sdk cancelPrepare");
            CFGameLife.cancelPrepare.postMessage(uid);
        },
        gameTerminated(uid) {
            console.log("sdk gameTerminated");
            CFGameLife.gameTerminated.postMessage(uid);
        },
        gameOver(uid) {
            console.log("sdk gameOver");
            CFGameLife.gameOver.postMessage(uid);
        },
        gameStart(){
            console.log("sdk gameStart");
            CFGameLife.gameStart.postMessage("success");
        },
        playerRemoveWithUid(uid){
            console.log("sdk playerRemoveWithUid");
            CFGameLife.playerRemoveWithUid.postMessage(uid);
        },
        gameBackgroundMusicSet(mode){
            console.log("sdk gameBackgroundMusicSet");
            CFGameLife.gameBackgroundMusicSet.postMessage(mode);
        },
        gameSoundSet(mode){
            console.log("sdk gameSoundSet");
            CFGameLife.gameSoundSet.postMessage(mode);
        },
        quitGame(){
            console.log("sdk quitGame");
            CFGameLife.quitGame.postMessage("success");
        },
        gameLoadOfflineProps() {
            console.log("sdk gameLoadOfflineProps");
            CFGameLife.gameLoadOfflineProps.postMessage("success");
        },
        onGamePurchaseResult(code, orderId) {
            console.log("onGamePurchaseResult()");
            var message = {
                data:{
                    code:code,
                    orderId:orderId
                }
            };
            
            CFGameLife.onGamePurchaseResult.postMessage(message);
        },
        onGameMusicStartPlay(musicId,musicUrl,isLoop){
            console.log("sdk onGameMusicStartPlay");
            var message = {
                data:{
                    musicId:musicId,
                    musicUrl:musicUrl,
                    isLoop:isLoop
                }
            };
            
            CFGameLife.onGameMusicStartPlay.postMessage(message);
        },
        onGameMusicStopPlay(musicId){
            console.log("sdk onGameMusicStopPlay");
            CFGameLife.onGameMusicStopPlay.postMessage(musicId);
            
        },
        onGameEffectSoundStartPlay(soundId,soundUrl,isLoop){
            console.log("sdk onGameEffectSoundStartPlay");
            var message = {
                data:{
                    soundId:soundId,
                    soundUrl:soundUrl,
                    isLoop:isLoop
                }
            };
            
            CFGameLife.onGameEffectSoundStartPlay.postMessage(message);
        },
        onGameEffectSoundStopPlay(soundId){
            console.log("sdk onGameEffectSoundStopPlay");
            CFGameLife.onGameEffectSoundStopPlay.postMessage(soundId);
        },
        appCallGame(dataStr){
            console.log("sdk appCallGame");
            CFGameLife.appCallGame.postMessage(dataStr);
        },
        gameStateChange(data){
            console.log("sdk gameStateChange");
            CFGameLife.gameStateChange.postMessage(data);
        },
        playerStateChange(data){
            console.log("sdk playerStateChange");
            CFGameLife.playerStateChange.postMessage(data);
        },
        gameSendScreenshot(imageData,dataJson){
            console.log("sdk gameSendScreenshot")
            var message = {
                data:{
                    imageData:imageData,
                    dataJson:dataJson,
                }
            };
            CFGameLife.gameSendScreenshot.postMessage(message);
        }

    }
};

function getInvokeId(){
    var byteArray = new Uint32Array(1);
    window.crypto.getRandomValues(byteArray);
    return byteArray[0].toString();
}

function callCFJs(invokeId, data) {
    var callback = cfgCallJsBacks[invokeId];
    if(callback == undefined){
        console.log("callback is null !");
    } else {
        callback(JSON.stringify(data));
        delete (cfgCallJsBacks[invokeId]);
    }
}

window.CFGame=cf_game;
