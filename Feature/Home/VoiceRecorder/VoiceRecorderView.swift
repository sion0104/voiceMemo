//
//  VoiceRecoderView.swift
//  voiceMemo
//
//  Created by 최시온 on 12/1/24.
//

import SwiftUI

struct VoiceRecoderView: View {
    @StateObject private var voiceRecorderViewModel = VoiceRecorderViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                TitleView()
                
                if voiceRecorderViewModel.recordedFiles.isEmpty{
                    AnnouncementView()
                } else {
                    voiceRecorderListView(voiceRecorderViewModel: voiceRecorderViewModel)
                        .padding(.top, 15)
                }
                Spacer()
            }
            RecordBtnView(voiceRecorderViewModel: voiceRecorderViewModel)
                .padding(.trailing, 20)
                .padding(.bottom, 50)
        }
        .alert(
            "선택된 음성메모를 삭제하시겠습니까?",
            isPresented: $voiceRecorderViewModel.isDisplayRemoveVoiceRecorderAlert
        ) {
            Button("삭제", role: .destructive) {
                voiceRecorderViewModel.removeSelectedVoiceRecord()
            }
            Button("취소", role: .cancel) {}
        }
        .alert(
            voiceRecorderViewModel.alertMessage,
            isPresented: $voiceRecorderViewModel.isDisplayAlert
        ) {
            Button("확인", role: .cancel) {}
        }
    }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("음성메모")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.customBlack)
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}

// MARK: - 음성메모 안내 뷰
private struct AnnouncementView: View {
    fileprivate var body: some View{
        VStack(spacing: 15){
            Rectangle()
                .fill(.customCoolGray)
                .frame(height: 1)
            
            Spacer()
                .frame(height: 100)
            
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 20, height: 20)
            Text("현재 등록된 음성메모가 없습니다.")
            Text("하단의 녹음 버튼을 눌러 음성메모를 시작해주세요.")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundStyle(.customGray2)
    }
}

// MARK: - 음성메모 리스트 뷰
private struct voiceRecorderListView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecoderViewModel
    
    fileprivate init(voiceRecorderViewModel: VoiceRecoderViewModel) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
    }
    
    fileprivate var body: some View {
        ScrollView(.vertical){
            VStack{
                Rectangle()
                    .fill(Color.customGray2)
                    .frame(height: 1)
                
                ForEach(voiceRecorderViewModel.recordedFiles, id: \.self){ recordedfile in
                    VoiceRecorderCellView(
                        voiceRecorderViewModel: voiceRecorderViewModel,
                        recordedFile: recordedfile
                    )
                }
            }
        }
    }
}

// MARK: - 음성메모 셀 뷰
private struct VoiceRecorderCellView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecoderViewModel
    private var recordedFile: URL
    private var creationDate: Date?
    private var duration: TimeInterval?
    private var progressBarValue: Float {
        if voiceRecorderViewModel.selectedRecordedFile == recordedFile
            && (voiceRecorderViewModel.isPlaying || voiceRecorderViewModel.isPaused) {
            return Float(voiceRecorderViewModel.playedTime) / Float(duration ?? 1)
        } else {
            return 0
        }
    }
    
    fileprivate init(
        voiceRecorderViewModel: VoiceRecoderViewModel,
        recordedFile: URL
    ) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
        self.recordedFile = recordedFile
        (self.creationDate, self.duration) = voiceRecorderViewModel.getFileInfo(for: recordedFile)
    }
    
    fileprivate var body: some View {
        VStack{
            Button {
                voiceRecorderViewModel.voiceRecordCellTapped(recordedFile)
            } label: {
                VStack{
                    HStack{
                        Text(recordedFile.lastPathComponent)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.customBlack)
                        
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 5)
                    
                    HStack{
                        if let creationDate = creationDate {
                            Text(creationDate.formattedVoiceRecorderTime)
                                .font(.system(size: 14))
                                .foregroundStyle(.customIconGray)
                        }
                        Spacer()
                        
                        if voiceRecorderViewModel.selectedRecordedFile != recordedFile,
                           let duration = duration {
                            Text(duration.formattedTimeInterval)
                                .font(.system(size: 14))
                                .foregroundStyle(.customIconGray)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            
            if voiceRecorderViewModel.selectedRecordedFile == recordedFile {
                VStack{
                    ProgressBar(progress: progressBarValue)
                        .frame(height: 2)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    HStack{
                        Text(voiceRecorderViewModel.playedTime.formattedTimeInterval)
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.customIconGray)
                        
                        Spacer()
                        
                        if let duration = duration {
                            Text(duration.formattedTimeInterval)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(.customIconGray)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    HStack{
                        Spacer()
                        
                        Button {
                            if voiceRecorderViewModel.isPaused {
                                voiceRecorderViewModel.resumePlaying()
                            } else {
                                voiceRecorderViewModel.startPlaying(recordingURL: recordedFile)
                            }
                        } label: {
                            Image("play")
                                .renderingMode(.template)
                                .foregroundStyle(.customBlack)
                        }
                        
                        Spacer()
                            .frame(width: 10)
                        
                        Button {
                            if voiceRecorderViewModel.isPlaying {
                                voiceRecorderViewModel.pausePlaying()
                            }
                        } label: {
                            Image("pause")
                                .renderingMode(.template)
                                .foregroundStyle(.customBlack)
                        }
                        
                        Spacer()
                        
                        Button {
                            voiceRecorderViewModel.removeBtnTapped()
                        } label: {
                            Image("trash")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.customBlack)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Rectangle()
                .fill(.customGray2)
                .frame(height: 1)
        }
    }
}

// MARK: - 프로그래스 바
private struct ProgressBar: View {
    private var progress: Float
    
    fileprivate init(progress: Float) {
        self.progress = progress
    }
    
    fileprivate var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.customGray2)
                
                Rectangle()
                    .fill(.customGreen)
                    .frame(width: CGFloat(self.progress) * geometry.size.width)
            }
        }
    }
}

// MARK: - 녹음 버튼 뷰
private struct RecordBtnView: View {
    @ObservedObject private var voiceRecoderViewModel: VoiceRecoderViewModel
    
    fileprivate init(voiceRecoderViewModel: VoiceRecoderViewModel) {
        self.voiceRecoderViewModel = voiceRecoderViewModel
    }
    
    var body: some View {
        VStack{
            Spacer()
            
            HStack(){
                Spacer()
                
                Button {
                    voiceRecoderViewModel.recordBtnTapped()
                } label: {
                    if voiceRecoderViewModel.isRecording {
                        Image("mic_recording")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } else {
                        Image("mic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                    }
                }
            }
        }
    }
}

#Preview {
    VoiceRecoderView()
}
