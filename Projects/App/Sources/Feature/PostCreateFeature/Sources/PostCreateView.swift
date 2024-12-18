import SwiftUI

struct PostCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var titleTextField: String = ""
    @State private var locationText: String = "본관"
    @State private var showError: Bool = false
    @State private var images: [UIImage?] = [nil, nil, nil]
    @State private var showingImagePicker: Bool = false
    @State private var imagesPickerIndex: Int = 0
    @State var showingSheet: Bool = false
    @State var locationInfo: Bool = false
    @State var showingBottomSheet: Bool = false
    @State private var userSearchTextField: String = ""
    @State private var tagUserImages: [String] = ["", "", "", "", ""]
    @State private var tagUserName: [String] = ["", "", "", "", ""]
    @State private var tagUserYear: [Int] = [0, 0, 0, 0, 0]
    @State private var testTagUserImages: [UIImage?] = [nil, nil, nil, nil, nil]
    @State private var testTagUserName: [String] = ["", "", "", "", ""]
    @State private var testTagUserId: [Int?] = Array(repeating: nil, count: 5)
    @StateObject var viewModel: PostViewModel

    var body: some View {
        ZStack(alignment: .leading) {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            GPleAsset.Assets.chevronRight.swiftUIImage
                                .padding(.leading, 20)
                        }
                        Spacer()
                    }

                    Text("사진 업로드")
                        .foregroundStyle(.white)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                }
                .padding(.bottom, 16)

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("사진")
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                            .padding(.leading, 24)
                            .padding(.top, 24)

                        HStack(spacing: 12) {
                            Group {
                                if let image = images[0] {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 160, height: 160)
                                        .cornerRadius(8)
                                } else {
                                    Image("imageFrame")
                                }
                            }
                            .onTapGesture {
                                if images[0] == nil {
                                    imagesPickerIndex = 0
                                    showingImagePicker = true
                                } else {
                                    imagesPickerIndex = 0
                                    self.showingSheet = true
                                }
                            }

                            VStack(spacing: 8) {
                                (images[1] != nil ? Image(uiImage: images[1]!) : Image("imageFrame"))
                                    .resizable()
                                    .frame(width: 76, height: 76)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        if images[0] != nil {
                                            if images[1] == nil {
                                                imagesPickerIndex = 1
                                                showingImagePicker = true
                                            } else {
                                                imagesPickerIndex = 1
                                                self.showingSheet = true
                                            }
                                        }
                                    }
                                    .opacity(images[0] != nil ? 1.0 : 0.5)

                                (images[2] != nil ? Image(uiImage: images[2]!) : Image("imageFrame"))
                                    .resizable()
                                    .frame(width: 76, height: 76)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        if images[1] != nil {
                                            if images[2] == nil {
                                                imagesPickerIndex = 2
                                                showingImagePicker = true
                                            } else {
                                                imagesPickerIndex = 2
                                                self.showingSheet = true
                                            }
                                        }
                                    }
                                    .opacity(images[1] != nil ? 1.0 : 0.5)
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.top, 6)

                        Text("사진은 최대 3개까지 업로드가 가능합니다.")
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                            .padding(.leading, 20)
                            .padding(.top, 8)

                        GPleTextField(
                            "제목을 입력해주세요",
                            text: $titleTextField,
                            title: "제목",
                            textCount: titleTextField.count,
                            useTextCount: true,
                            errorText: "제목을 입력 해주세요.",
                            isError: showError,
                            onSubmit: {
                                if titleTextField.isEmpty {
                                    showError = true
                                } else {
                                    showError = false
                                }
                            }
                        )
                        .padding(.top, 32)

                        Text("위치")
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                            .padding(.leading, 24)
                            .padding(.top, 32)

                        ZStack(alignment: .topLeading) {
                            HStack(spacing: 6) {
                                Text(locationText)
                                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                                    .foregroundStyle(.white)

                                Image(locationInfo ? "grayUp" : "grayDown")
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(locationInfo ? GPleAsset.Color.gray950.swiftUIColor : GPleAsset.Color.gray1000.swiftUIColor, lineWidth: 1.5)
                            )
                            .padding(.top, 4)
                            .padding(.leading, 20)
                            .onTapGesture {
                                locationInfo.toggle()
                            }

                            if locationInfo {
                                VStack(spacing: 12) {
                                    Text("본관")
                                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                                        .foregroundStyle(.white)
                                        .onTapGesture {
                                            locationText = "본관"
                                            locationInfo.toggle()
                                        }

                                    Divider()
                                        .frame(width: 58, height: 1)
                                        .overlay(GPleAsset.Color.gray950.swiftUIColor)

                                    Text("금봉관")
                                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                                        .foregroundStyle(.white)
                                        .onTapGesture {
                                            locationText = "금봉관"
                                            locationInfo.toggle()
                                        }

                                    Divider()
                                        .frame(width: 58, height: 1)
                                        .overlay(GPleAsset.Color.gray950.swiftUIColor)

                                    Text("동행관")
                                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                                        .foregroundStyle(.white)
                                        .onTapGesture {
                                            locationText = "동행관"
                                            locationInfo.toggle()
                                        }

                                    Divider()
                                        .frame(width: 58, height: 1)
                                        .overlay(GPleAsset.Color.gray950.swiftUIColor)

                                    Text("산책로")
                                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                                        .foregroundStyle(.white)
                                        .onTapGesture {
                                            locationText = "산책로"
                                            locationInfo.toggle()
                                        }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(locationInfo ? GPleAsset.Color.gray950.swiftUIColor : GPleAsset.Color.gray1000.swiftUIColor, lineWidth: 1.5)
                                )
                                .padding(.top, 62)
                                .padding(.leading, 20)
                            }
                        }

                        Text("태그")
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                            .padding(.leading, 24)
                            .padding(.top, 32)


                        ForEach(0..<5) { tag in
                            if tagUserName[tag] != "" && tagUserYear[tag] != 0 {
                                HStack(spacing: 4) {
                                    if let url = URL(string: tagUserImages[tag]) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 32, height: 32)
                                                .clipShape(Circle())
                                        } placeholder: {
                                            GPleAsset.Assets.profile.swiftUIImage
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 32, height: 32)
                                        }
                                        .padding(.leading, 24)

                                    } else {
                                        GPleAsset.Assets.profile.swiftUIImage
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .padding(.leading, 24)
                                    }

                                    Text(tagUserName[tag])
                                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                        .foregroundStyle(.white)
                                        .padding(.leading, 4)
                                    Text("· \(tagUserYear[tag])학년")
                                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                        .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)

                                    Spacer()

                                    Button {
                                        tagUserName[tag] = ""
                                        tagUserYear[tag] = 0
                                        tagUserImages[tag] = ""
                                    } label: {
                                        HStack(spacing: 8) {
                                            GPleAsset.Assets.grayUserMinus.swiftUIImage

                                            Text("삭제하기")
                                                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                                .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
                                        )
                                        .padding(.trailing, 20)
                                    }
                                }
                                .padding(.vertical, 10)
                            }
                        }

                        Button {
                            viewModel.allUserList { success in
                                if success {
                                    showingBottomSheet.toggle()
                                } else {
                                    print("Viewㅣ유저 리스트 불러오기 실패")
                                }
                            }

                        } label: {
                            HStack(spacing: 8) {
                                GPleAsset.Assets.plus.swiftUIImage

                                Text("인원 추가")
                                    .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
                            )
                            .padding(.top, 4)
                            .padding(.leading, 20)
                        }

                        ExpoButton(text: "완료",
                                   horizontalPadding: 167,
                                   verticalPadding: 16,
                                   backColor: GPleAsset.Color.gray1000.swiftUIColor,
                                   buttonState: isFormValid,
                                   buttonOkColor: GPleAsset.Color.main.swiftUIColor
                        ){

                            if !images.isEmpty {
                                let uiImages = images.compactMap { $0 }
                                let userIdList = testTagUserId.compactMap { $0 }
                                viewModel.setupImage(images: uiImages)
                                viewModel.setupTitle(title: titleTextField)
                                viewModel.setupLocation(location: locationText)
                                viewModel.setupUserList(userList: userIdList)
                                viewModel.uploadImages { success in
                                    if success {
                                        print("이미지 업로드가 성공했습니다.")
                                        viewModel.createPost { success in
                                            print("Viewㅣ포스트 생성이 성공했습니다.")
                                        }
                                    } else {
                                        print("Viewㅣ이미지 업로드 실패")
                                    }
                                }
                            }

                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 93)
                        .disabled(!isFormValid)
                    }
                }

                Spacer()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $images[imagesPickerIndex])
            }
            .confirmationDialog("", isPresented: $showingSheet, titleVisibility: .hidden) {
                Button("사진 변경") {
                    showingImagePicker = true
                }

                Button("사진 삭제", role: .destructive) {
                    images.remove(at: imagesPickerIndex)
                    images.append(nil)
                }

                Button("사진 전체 삭제", role: .destructive) {
                    images = [nil, nil, nil]
                }

                Button("취소", role: .cancel) {
                }
            }
            .sheet(isPresented: $showingBottomSheet) {
                VStack(spacing: 32) {
                    ZStack {
                        GPleTextField(
                            "찾으시는 분을 검색해 보세요",
                            text: $userSearchTextField,
                            useTextCount: false,
                            onSubmit: {
                                if titleTextField.isEmpty {
                                    showError = true
                                } else {
                                    showError = false
                                }
                            }
                        )

                        HStack {
                            Spacer()
                            GPleAsset.Assets.search.swiftUIImage
                                .padding(.trailing, 36)
                        }
                    }
                    .padding(.top , 54)

                    ForEach(viewModel.allUserList.indices, id: \.self) { tag in
                        let student = viewModel.allUserList[tag]
                        searchUserList(
                            userProfileImage: student.profileImage,
                            userName: student.name,
                            userYear: student.grade,
                            userId: student.id,
                            userProfileImageList: $tagUserImages[tag],
                            userNameList: $tagUserName[tag],
                            userYearList: $tagUserYear[tag],
                            testTagUserId: $testTagUserId[tag]
                        )
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(GPleAsset.Color.gray1050.swiftUIColor)
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(520)])
            }

        }
    }

    private var isFormValid: Bool {
        return !titleTextField.isEmpty &&
        images[0] != nil
    }
}

import SwiftUI

@ViewBuilder
func searchUserList(
    userProfileImage: String,
    userName: String,
    userYear: Int,
    userId: Int,
    userProfileImageList: Binding<String>,
    userNameList: Binding<String>,
    userYearList: Binding<Int>,
    testTagUserId: Binding<Int?>
) -> some View {
    Button {
        userProfileImageList.wrappedValue = userProfileImage
        userNameList.wrappedValue = userName
        userYearList.wrappedValue = userYear
        testTagUserId.wrappedValue = userId

        print("추가: \(userId)")
        print("추가: \(userName)")
        print("추가: \(userYear)학년")
    } label: {
        HStack(spacing: 4) {
            if let url = URL(string: userProfileImage) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                } placeholder: {
                    GPleAsset.Assets.profile.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
                .padding(.leading, 24)
            } else {
                GPleAsset.Assets.profile.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.leading, 24)
            }

            Text(userName)
                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                .foregroundStyle(.white)
                .padding(.leading, 4)

            Text("· \(userYear)학년")
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)

            Spacer()

            HStack(spacing: 8) {
                GPleAsset.Assets.grayUserPlus.swiftUIImage

                Text("추가하기")
                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                    .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
            )
            .padding(.trailing, 20)
        }
    }
}

